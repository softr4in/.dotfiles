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

# function to install the macOS bare minimum needed for the rest of the installation;
# apple cli, brew, python 3, pip3, bash 5.2, ansible, bitwarden-cli
function macos_setup() {
  if ! [[ -x "$(command -v xcode-select)" ]]; then
    __task "Installing Apple's command line tools (xcode-select)"
    _cmd 'xcode-select --install'
  fi

  # export PATH in terminal once since .zprofile is not stowed yet and stow comes from brew
  if ! [[ -x "/opt/homebrew/bin" ]]; then
    __task "Installing Homebrew"
    _cmd '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
    _cmd 'export PATH="/opt/homebrew/bin:$PATH"'
  fi

  if ! [[ -x "/opt/homebrew/bin" ]]; then
    __task "Installing Homebrew"
    _cmd 'export PATH="/opt/homebrew/bin:$PATH"'
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  if ! [[ -x "/opt/homebrew/bin/stow" ]]; then
    __task "Install stow and run stow script"
    _cmd "brew install stow"
    _cmd "/bin/zsh $HOME/.dotfiles/ansible_playbooks/tris_macos_playbook/roles/stow/files/stowall.sh"
  fi

  if ! [[ -x "/opt/homebrew/bin/pipx" ]]; then
    __task "Installing pipx, watchdog, argcomplete, ansible"
    _cmd "brew install pipx"
    _cmd "pipx install --include-deps ansible"
    _cmd "pipx inject ansible watchdog"
    _cmd "pipx inject ansible argcomplete"
    # installs pipx to python3 in ansible's virtual environment
    _cmd "python3 -m pip install pipx"
  fi

  # >= bash 4.2 needed for ansible shell completion; might as well upgrade to bash 5.2
  if [[ "$(bash --version | head -n 1 | awk '{print $4}' | cut -d'.' -f1,2)" < "5.2" ]]; then
    __task "Installing latest bash (5.2)"
    _cmd "brew install bash"
  fi

  # WARN: as of 25-Aug-2024: no linux arm64 support for either bitwarden cli or 1password cli;
  if ! [[ -x "$(command -v bw)" ]]; then
    __task "Install, login and unlock Bitwarden cli"
    _cmd "brew install bitwarden-cli"
    _cmd "bw login"
    _cmd "bw unlock"
    _cmd "export BW_SESSION=$(bw unlock --raw)"
    _cmd "bw status | grep -q 'unlocked'"
  fi
}

# NOTE: Cloning dotfiles, installing ansible and running ansible-playbook

# script exits immediately if any command fails
set -e

# 1. Check if .dotfiles repo exists in $HOME; if not, clone .dotfiles repo into $HOME;
# make sure your remote repo url is valid or this step will fail
if [[ ! -d "$DOTFILES_DIR" ]]; then
  __task "Cloning repository"
  _cmd "cd $HOME"
  _cmd "git clone https://github.com/softr4in/.dotfiles.git"
fi

# 2. Install the bare minimum needed for ansible to take over the rest of the deployment
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

# 3. Run ansible-playbook and checks for ansible-vault password to decrypt on the fly;
#    decrypted data exists only in memory and isn't written to disk
__task "Running playbook"; _task_done
  printf "${OVERWRITE}${LGREEN} [✓]  ${LGREEN}Running playbook with vault secret${NC}\n"
  ansible-playbook -t first-run -i ~/.dotfiles/ansible_playbooks/tris_macos_playbook/inventory --vault-password-file $VAULT_SECRET ~/.dotfiles/ansible_playbooks/tris_macos_playbook/main.yml -v

# 4. Messages to relay successful execution of script
echo -e "${CHECK_MARK} ${GREEN}Script for first run of playbook successfully completed!${NC}"
