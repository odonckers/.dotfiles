#!/usr/bin/env zsh

dotnet-link-libraries() {
  local package="$1"
  local lib_src="$HOME/dev/bethel/cdh-meta/libraries/src"

  if [[ -z "$package" ]]; then
    if command -v fzf &>/dev/null; then
      package=$(find "$lib_src" -mindepth 1 -maxdepth 1 -type d | xargs -I{} basename {} | fzf --prompt="Select package: ")
      [[ -z "$package" ]] && return 1
    else
      echo "Usage: dotnet-link <package>" >&2
      return 1
    fi
  fi

  local csproj="$lib_src/${package}/${package}.csproj"

  dotnet remove package "$package"
  dotnet add reference "$csproj"
  dotnet sln ../.. add "$csproj"

  if [[ "$package" == "JW.Storage" ]]; then
    local csproj2="$lib_src/JW.Storage.Generators/JW.Storage.Generators.csproj"
    dotnet add reference "$csproj2"
    dotnet sln ../.. add "$csproj2"

    echo -e "\033[33mWARNING: You must add \`OutputItemType=\"Analyzer\" ReferenceOutputAssembly=\"false\"\` manually!\033[0m" >&2
  fi
}
