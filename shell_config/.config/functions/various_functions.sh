#!/opt/homebrew/bin/bash

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# provide your custom error message for an expected error condition handled by your logic.
function die () {
  echo >&2 "$@"
  exit 1
}
