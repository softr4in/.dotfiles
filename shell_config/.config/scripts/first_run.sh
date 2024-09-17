#!/bin/bash

# NOTE: formatting

# color codes for styling output in terminal
RESTORE='\033[0m'
NC='\033[0m'
BLACK='\033[00;30m'
RED='\033[00;31m'
GREEN='\033[00;32m'
YELLOW='\033[00;33m'
BLUE='\033[00;34m'
PURPLE='\033[00;35m'
CYAN='\033[00;36m'
SEA="\\033[38;5;49m"
LIGHTGRAY='\033[00;37m'
LBLACK='\033[01;30m'
LRED='\033[01;31m'
LGREEN='\033[01;32m'
LYELLOW='\033[01;33m'
LBLUE='\033[01;34m'
LPURPLE='\033[01;35m'
LCYAN='\033[01;36m'
WHITE='\033[01;37m'
OVERWRITE='\e[1A\e[K'

#emoji codes for styling output in terminal
CHECK_MARK="${GREEN}\xE2\x9C\x94${NC}"
X_MARK="${RED}\xE2\x9C\x96${NC}"
PIN="${RED}\xF0\x9F\x93\x8C${NC}"
CLOCK="${GREEN}\xE2\x8C\x9B${NC}"
ARROW="${SEA}\xE2\x96\xB6${NC}"
BOOK="${RED}\xF0\x9F\x93\x8B${NC}"
HOT="${ORANGE}\xF0\x9F\x94\xA5${NC}"
WARNING="${RED}\xF0\x9F\x9A\xA8${NC}"
RIGHT_ANGLE="${GREEN}\xE2\x88\x9F${NC}"

# Paths
DOTFILES_LOG="$HOME/.dotfiles.log"
VAULT_SECRET="$HOME/.dotfiles/ansible_playbooks/tris_macos_playbook/scripts/vault_secrets.sh"
DOTFILES_DIR="$HOME/.dotfiles"

# NOTE: function definitions

# function to print task that's currently executing in terminal
function __task {
  if [[ $TASK != "" ]]; then
    printf "${OVERWRITE}${LGREEN} [✓]  ${LGREEN}${TASK}\n"
  fi
  TASK=$1
  printf "${LBLACK} [ ]  ${TASK} \n${LRED}"
}

# function to perform command with error checking in terminal;
# prints error messages (if any)
function _cmd {
  if ! [[ -f $DOTFILES_LOG ]]; then
    touch $DOTFILES_LOG
  fi
  > $DOTFILES_LOG
  if eval "\$1" 1> /dev/null 2> $DOTFILES_LOG; then
    return 0
  fi
  printf "${OVERWRITE}${LRED} [X]  ${TASK}${LRED}\n"
  while read line; do
    printf "      ${line}\n"
  done < $DOTFILES_LOG
  printf "\n"
  rm $DOTFILES_LOG
  exit 1
}

# function to clear current task
function _clear_task {
  TASK=""
}

# function to mark current task as completed
function _task_done {
  printf "${OVERWRITE}${LGREEN} [✓]  ${LGREEN}${TASK}\n"
  _clear_task
}

# function to install the brew and pip packages
function macos_setup() {
  export PATH="/opt/homebrew/bin:~/.local/bin:$PATH"

  if ! [[ -x "/opt/homebrew/bin" ]]; then
    __task "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    echo "Homebrew is already installed."
  fi

  __task "Installing Homebrew bundle"
  _cmd "brew bundle install --file=~/homefiles/Brewfile"

  __task "Unstowing and restowing all config files"
  _cmd "source ~/.dotfiles/shell_config/.config/scripts/stowall.sh"

  if ! [[ -x "~/.local/bin/ansible" ]]; then
    __task "Installing ansible"
    _cmd "pipx install --include-deps ansible"
  else
    echo "ansible is already installed."
  fi

  # needs to source .profile again to detect ansible in PATH
  source /Users/trisyong/.config/scripts/re_source.sh

  _cmd "pipx inject ansible watchdog"
  _cmd "pipx inject ansible argcomplete"

  if ! [[ -x "~/.local/pipx/venvs/ansible/bin/python3" ]]; then
    __task "Installs pipx to python3 in ansible's virtual environment"
    /bin/bash -c "python3 -m pip install pipx"
  else
    echo "python3 in ansible already installed."
  fi

  # Unlock bitwarden-cli
  /Users/tristong/.config/scripts/bw_unlock.sh
}

# NOTE: Cloning dotfiles, installing ansible and running ansible-playbook

# 1. Check if .dotfiles repo exists in $HOME; if not, clone .dotfiles repo into $HOME;
# make sure your remote repo url is valid or this step will fail

if [[ ! -d "$DOTFILES_DIR" ]]; then
  __task "Cloning repository"
  _cmd "cd $HOME"
  _cmd "git clone https://github.com/softr4in/.dotfiles.git"
fi

# 2. Install the brew and pip packages
if [[ "$OSTYPE" == darwin* ]]; then
  ID="macos"
else
  source /etc/os-release
fi
__task "Loading Setup for detected OS: $ID"
case $ID in
  macos)
    macos_setup
    ;;

  *)
    __task "Unsupported OS"
    _cmd "echo 'Unsupported OS'"
    ;;
esac

# 3. Install macOS defaults
source ~/.dotfiles/shell_config/.config/scripts/macos_defaults.sh

# 4. Run ansible-playbook and checks for ansible-vault password to decrypt on the fly;
#    decrypted data exists only in memory and isn't written to disk
__task "Running playbook"; _task_done
  printf "${OVERWRITE}${LGREEN} [✓]  ${LGREEN}Running playbook with vault secret${NC}\n"
  ansible-playbook -t first-run -i ~/.dotfiles/ansible_playbooks/tris_macos_playbook/inventory --vault-password-file $VAULT_SECRET ~/.dotfiles/ansible_playbooks/tris_macos_playbook/main.yml -v
