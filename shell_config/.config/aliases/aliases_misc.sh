#!/bin/bash

alias ls="eza --icons=always"
alias la="eza -la --icons=always"
alias cd="z"
alias stowall="source ~/.config/scripts/stowall.sh"
alias bw_unlock="source ~/.config/scripts/bw_unlock.sh"
alias dot_push="~/.config/scripts/dot_push.sh"
alias dot='ansible-playbook --vault-password-file $HOME/.dotfiles/ansible_playbooks/tris_macos_playbook/scripts/vault_secrets.sh $HOME/.dotfiles/ansible_playbooks/tris_macos_playbook/main.yml "$@"'
# python 3 in ansible's virtual environment
alias python3_ansible="/Users/trisyong/.local/pipx/venvs/ansible/bin/python3"

alias avec="ansible-vault encrypt --vault-password-file ~/.dotfiles/ansible_playbooks/tris_macos_playbook/scripts/vault_secrets.sh"
alias avdc="ansible-vault decrypt --vault-password-file ~/.dotfiles/ansible_playbooks/tris_macos_playbook/scripts/vault_secrets.sh"

alias avdeg="~/.config/scripts/add_ssh.sh"

# bash defaults to bash 5.2 instead of macOS's bash 3.2
alias bash="/opt/homebrew/bin/bash"

# A prettier echo $PATH for the human eye
alias path="echo $PATH | tr ':' '\n' | bat --plain --paging=never"

# Git
alias gcane='git commit --amend --no-edit'
alias ggl="git log --graph --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%an%C(reset)%C(bold yellow)%d%C(reset) %C(dim white)- %s%C(reset)' --all"
alias untrack="git update-index --assume-unchanged"
alias track="git update-index --no-assume-unchanged"
alias ls-untrack='git ls-files -v | grep "^[[:lower:]]"'
