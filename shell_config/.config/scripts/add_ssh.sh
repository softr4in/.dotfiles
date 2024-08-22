#!/bin/bash

if grep AES256 ~/.ssh/github.com/github-auth-ed25519; then
  ansible-vault decrypt --vault-password-file ~/.dotfiles/ansible_playbooks/tris_macos_playbook/scripts/vault_secrets.sh ~/.ssh/github.com/github-auth-ed25519
fi

ssh-add -t 24h ~/.ssh/github.com/github-auth-ed25519

ansible-vault encrypt --vault-password-file ~/.dotfiles/ansible_playbooks/tris_macos_playbook/scripts/vault_secrets.sh ~/.ssh/github.com/github-auth-ed25519
