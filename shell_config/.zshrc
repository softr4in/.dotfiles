# NOTE: `.zshrc' is sourced in interactive shells. It should contain commands to set up aliases, functions, options, key bindings, etc.

###############################################################################
# Aliases                                                                     #
###############################################################################

for file in ~/.config/aliases/*.sh; do
  source "$file"
done

###############################################################################
# Initializations                                                             #
###############################################################################

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

eval "$(zoxide init zsh)"

###############################################################################
# Functions                                                                   #
###############################################################################

source ~/.config/definitions/y_definition.sh
source ~/.config/definitions/misc_definitions.sh

###############################################################################
# Keybindings                                                                 #
###############################################################################

# Set up fzf keybindings and fuzzy completion
source <(fzf --zsh)

# This allows ALT+C to work with right option key on macOS instead of typing ç
bindkey "ç" fzf-cd-widget

# up and down arrow keys still work but I prefer this
bindkey '^K' history-search-backward
bindkey '^J' history-search-forward

###############################################################################
# Options                                                                     #
###############################################################################

# setup for command history
export HISTCONTROL=ignoredups
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify
