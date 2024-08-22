#!/bin/zsh

echo "Stowing Dotfiles..."

cd $HOME/.dotfiles

for file in $HOME/.dotfiles/*; do
  # Only run Stow on the directories in the dotfiles folder and not the individual files.
  # Using 'basename' strips the filepath from the directory name. 
  if [ -d ${file} ]; then
    stow -R $(basename $file)
    echo "$(basename $file) stowed."
  fi
done

# Return back to the your PWD from before you ran the script
cd ~- 

source ~/.zprofile
echo "Re-sourced .zprofile."

source ~/.zshrc
echo "Re-sourced .zshrc."
