# NOTE: `.zprofile` is sourced once in login shell per new window opened in your terminal emulator.
# Generally, write your environment variables here rather than in .zshenv.
# Add `source $HOME/.zprofile` to scripts that need specific variables from .zprofile.

###############################################################################
# Environment Variables (excluding $PATH)                                     #
###############################################################################

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# defaults to nvim for remote ssh
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

export VISUAL="$EDITOR"
export ANSIBLE_CONFIG="~/.dotfiles/ansible_playbooks/tris_macos_playbook/ansible.cfg"

###############################################################################
# Add directories to $PATH                                                    #
###############################################################################

source ~/.config/calls/add_path_calls.sh
