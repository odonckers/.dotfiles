# Small, dependency-free JSON reader for the dotfiles configuration.
#
# Usage:
#   awk -v query='appearance.theme' -f json.awk config.json
#   awk -v prefix='appearance.themes.modus.variants.dark.colors' \
#     -f json.awk config.json
#
# With no query or prefix, each leaf is printed as path<TAB>type<TAB>value.

function fail(message) {
  printf "dots: invalid JSON at byte %d: %s\n", position, message > "/dev/stderr"
  failed = 1
  exit 2
}

function skip_space() {
  while (position <= json_length && substr(json, position, 1) ~ /[[:space:]]/) {
    position++
  }
}

function parse_string(    result, character, escaped, unicode) {
  if (substr(json, position, 1) != "\"") {
    fail("expected string")
  }
  position++
  result = ""

  while (position <= json_length) {
    character = substr(json, position, 1)
    position++

    if (character == "\"") {
      return result
    }
    if (character != "\\") {
      result = result character
      continue
    }

    if (position > json_length) {
      fail("unterminated escape")
    }
    escaped = substr(json, position, 1)
    position++
    if (escaped == "\"" || escaped == "\\" || escaped == "/") {
      result = result escaped
    } else if (escaped == "b") {
      result = result sprintf("%c", 8)
    } else if (escaped == "f") {
      result = result sprintf("%c", 12)
    } else if (escaped == "n") {
      result = result "\n"
    } else if (escaped == "r") {
      result = result "\r"
    } else if (escaped == "t") {
      result = result "\t"
    } else if (escaped == "u") {
      unicode = substr(json, position, 4)
      if (unicode !~ /^[0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f]$/) {
        fail("invalid unicode escape")
      }
      result = result "\\u" unicode
      position += 4
    } else {
      fail("invalid escape")
    }
  }

  fail("unterminated string")
}

function emit(path, type, value, relative) {
  if (query != "") {
    if (path == query) {
      print value
      matched = 1
    }
    return
  }

  if (prefix != "") {
    if (path == prefix) {
      print "\t" value
      matched = 1
    } else if (index(path, prefix ".") == 1) {
      relative = substr(path, length(prefix) + 2)
      print relative "\t" value
      matched = 1
    }
    return
  }

  print path "\t" type "\t" value
}

function parse_number(path,    start, token, character) {
  start = position
  while (position <= json_length) {
    character = substr(json, position, 1)
    if (character ~ /[0-9eE+.-]/) {
      position++
    } else {
      break
    }
  }
  token = substr(json, start, position - start)
  if (token !~ /^-?(0|[1-9][0-9]*)(\.[0-9]+)?([eE][+-]?[0-9]+)?$/) {
    fail("invalid number")
  }
  emit(path, "number", token)
}

function parse_array(path,    index_number, child_path, character) {
  position++
  skip_space()
  if (substr(json, position, 1) == "]") {
    position++
    return
  }

  index_number = 0
  while (position <= json_length) {
    child_path = path "[" index_number "]"
    parse_value(child_path)
    index_number++
    skip_space()
    character = substr(json, position, 1)
    if (character == "]") {
      position++
      return
    }
    if (character != ",") {
      fail("expected comma or closing bracket")
    }
    position++
    skip_space()
  }

  fail("unterminated array")
}

function parse_object(path,    key, child_path, character) {
  position++
  skip_space()
  if (substr(json, position, 1) == "}") {
    position++
    return
  }

  while (position <= json_length) {
    key = parse_string()
    skip_space()
    if (substr(json, position, 1) != ":") {
      fail("expected colon")
    }
    position++
    child_path = (path == "" ? key : path "." key)
    parse_value(child_path)
    skip_space()
    character = substr(json, position, 1)
    if (character == "}") {
      position++
      return
    }
    if (character != ",") {
      fail("expected comma or closing brace")
    }
    position++
    skip_space()
  }

  fail("unterminated object")
}

function parse_value(path,    character) {
  skip_space()
  character = substr(json, position, 1)

  if (character == "{") {
    parse_object(path)
  } else if (character == "[") {
    parse_array(path)
  } else if (character == "\"") {
    emit(path, "string", parse_string())
  } else if (substr(json, position, 4) == "true") {
    position += 4
    emit(path, "boolean", "true")
  } else if (substr(json, position, 5) == "false") {
    position += 5
    emit(path, "boolean", "false")
  } else if (substr(json, position, 4) == "null") {
    position += 4
    emit(path, "null", "null")
  } else if (character ~ /[-0-9]/) {
    parse_number(path)
  } else {
    fail("expected value")
  }
}

{
  if (NR > 1) {
    json = json "\n"
  }
  json = json $0
}

END {
  if (failed) {
    exit 2
  }
  position = 1
  json_length = length(json)
  parse_value("")
  skip_space()
  if (position <= json_length) {
    fail("trailing content")
  }
  if ((query != "" || prefix != "") && !matched) {
    exit 3
  }
}
