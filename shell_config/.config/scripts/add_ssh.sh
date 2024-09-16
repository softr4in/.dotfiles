#!/bin/bash

if grep AES256 ~/homefiles/auth/.ssh/github.com/github-auth-ed25519; then
  ansible-vault decrypt --vault-password-file ~/.dotfiles/ansible_playbooks/tris_macos_playbook/scripts/vault_secrets.sh ~/auth/homefiles/.ssh/github.com/github-auth-ed25519
fi

ssh-add -t 24h ~/homefiles/auth/.ssh/github.com/github-auth-ed25519

ansible-vault encrypt --vault-password-file ~/.dotfiles/ansible_playbooks/tris_macos_playbook/scripts/vault_secrets.sh ~/homefiles/auth/.ssh/github.com/github-auth-ed25519
