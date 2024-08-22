#!/bin/bash

# Checks if bw is unlocked; if not, login if necessary, then unlock.
if bw status | grep -q "unlocked"; then
  echo "Bitwarden CLI is unlocked."
else
  if bw status | grep -q "unauthenticated"; then
    bw login
  fi
  export BW_SESSION=$(bw unlock --raw)
  echo "Bitwarden CLI is now unlocked."
fi
