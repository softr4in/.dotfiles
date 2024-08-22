#!/bin/bash

set -e

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

# If github ssh key is not decrypted yet, do it. 
if grep AES256 ~/.ssh/github.com/github-auth-ed25519; then
  ansible-vault decrypt --vault-password-file ~/.dotfiles/ansible_playbooks/tris_macos_playbook/scripts/vault_secrets.sh ~/.ssh/github.com/github-auth-ed25519
  echo "Github SSH key is decrypted."
fi

# If github ssh key is already decrypted,
# add to ssh-agent, encrypt key, push
if ! grep AES256 ~/.ssh/github.com/github-auth-ed25519; then
  killall ssh-agent || true
  eval $(ssh-agent -s)
  ssh-add -t 24h $HOME/.ssh/github.com/github-auth-ed25519
fi

# cd into dotfiles dir, push and return to previous dir
cd ~/.dotfiles
git push
cd ~-

# re-encrypt key
ansible-vault encrypt --vault-password-file ~/.dotfiles/ansible_playbooks/tris_macos_playbook/scripts/vault_secrets.sh ~/.ssh/github.com/github-auth-ed25519
echo "Github SSH key is encrypted."
