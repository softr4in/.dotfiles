#!/bin/bash

# provide your custom error message for an expected error condition handled by your logic.
function die () {
  echo >&2 "$@"
  exit 1
}
