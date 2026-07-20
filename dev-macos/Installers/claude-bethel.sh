#!/usr/bin/env bash

# Clones Claude Desktop into a second app bundle ("Claude Bethel") that keeps its
# own login, history and MCP config in ~/Library/Application Support/Claude-Bethel.
#
# macOS keys an app's identity off CFBundleIdentifier, so the clone needs its own
# identifier to be treated as a separate app. Changing anything inside a signed
# bundle invalidates Apple's signature, so the whole thing is re-signed ad-hoc
# from the inside out afterwards.
#
# Re-run this after Claude Desktop updates - the clone does not auto-update.
# https://melkon.tech/blog/two-claude-accounts-mac

set -euo pipefail

SOURCE_APP="/Applications/Claude.app"
TARGET_APP="$HOME/Applications/Claude Bethel.app"
BUNDLE_NAME="Claude Bethel"
BUNDLE_ID="com.anthropic.claudefordesktop.bethel"
USER_DATA_DIR="$HOME/Library/Application Support/Claude-Bethel"

if [ ! -d "$SOURCE_APP" ]; then
  echo "🟥 $SOURCE_APP not found - install Claude Desktop first"
  exit 1
fi

# A running clone means busy binaries, and re-signing them mid-flight corrupts the bundle
if pgrep -f "$TARGET_APP" >/dev/null 2>&1; then
  echo "🟥 $BUNDLE_NAME is running - quit it and re-run"
  exit 1
fi

echo "🟪 Cloning Claude Desktop to $BUNDLE_NAME..."

# The bundle is a derived artifact; user data lives in USER_DATA_DIR and is untouched
mkdir -p "$(dirname "$TARGET_APP")"
rm -rf "$TARGET_APP"
cp -R "$SOURCE_APP" "$TARGET_APP"

# Stale quarantine/provenance attributes trip up codesign
xattr -cr "$TARGET_APP"

# ---- Rewrite bundle identity -------

# CFBundleName is deliberately left alone. Electron builds its helper paths from
# it at startup ("<CFBundleName> Helper.app"), so renaming it makes the app abort
# with "Unable to find helper app" before a window ever appears. CFBundleIdentifier
# is what macOS keys app identity off anyway, and CFBundleDisplayName covers Finder.
plist="$TARGET_APP/Contents/Info.plist"
/usr/libexec/PlistBuddy -c "Set :CFBundleDisplayName '$BUNDLE_NAME'" "$plist"
/usr/libexec/PlistBuddy -c "Set :CFBundleIdentifier '$BUNDLE_ID'" "$plist"

# ---- Wrap the launcher -------------

# Wrapping the executable (rather than relying on the app to pick a directory)
# means every launch path - Dock, Spotlight, `open` - gets the right data dir.
echo "🟪 Pointing $BUNDLE_NAME at $USER_DATA_DIR..."

exe="$TARGET_APP/Contents/MacOS/Claude"
real="$TARGET_APP/Contents/MacOS/Claude.real"
mv "$exe" "$real"

cat >"$exe" <<EOF
#!/bin/zsh
APP_DIR="\$(cd "\$(dirname "\$0")" && pwd)"
exec "\$APP_DIR/Claude.real" --user-data-dir="$USER_DATA_DIR" "\$@"
EOF
chmod +x "$exe"

# ---- Re-sign inside out ------------

# Nested code must be signed before its container, otherwise sealing the outer
# bundle bakes in hashes that the later inner signatures invalidate.
echo "🟪 Re-signing $BUNDLE_NAME..."

find "$TARGET_APP/Contents/Frameworks" -maxdepth 1 -name "*.framework" -type d \
  -exec codesign --force --sign - {} \;
find "$TARGET_APP/Contents/Frameworks" -maxdepth 1 -name "*.app" -type d \
  -exec codesign --force --sign - {} \;
find "$TARGET_APP/Contents/Helpers" -maxdepth 1 -name "*.app" -type d \
  -exec codesign --force --sign - {} \;

for f in "$TARGET_APP/Contents/Helpers/"* "$real"; do
  [ -f "$f" ] && codesign --force --sign - "$f"
done

codesign --force --sign - "$TARGET_APP"
codesign --verify --deep --strict "$TARGET_APP"

# ---- Refresh Launch Services -------

# Without this the new bundle ID stays invisible to Spotlight, Dock and `open -a`
lsregister="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister"
"$lsregister" -f "$TARGET_APP"
killall Dock Finder

echo "✅ $BUNDLE_NAME installed - launch it and sign in with your secondary account"
