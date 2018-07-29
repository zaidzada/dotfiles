# .bash_functions
#
# Functions

# Create a new directory and enter it
mkd() {
  mkdir -p "$@" && cd "$@"
}

bkp() {
  cp "$@" $(date +%Y%m%d_%s_)"$@"
}

# Set colors for man
man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

# Create a data URL from a file
dataurl() {
  local mimeType=$(file -b --mime-type "$1")
  if [[ $mimeType == text/* ]]; then
    mimeType="${mimeType};charset=utf-8"
  fi
  echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')"
}

# Start an HTTP server from a directory, optionally specifying the port
server() {
  local port="${1:-8000}"
  sleep 1 && open "http://localhost:${port}/" &
  python3 -m http.server $port
}

# Syntax-highlight JSON strings or files
# Usage: `json '{"foo":42}'` or `echo '{"foo":42}' | json`
json() {
  if [ -t 0 ]; then # argument
    python -m json.tool <<< "$*" | pygmentize -l javascript
  else # pipe
    python -m json.tool | pygmentize -l javascript
  fi
}
