source ~/.config/definitions/add_path_definitions.sh

# The last function call of addToPath is at the very end of $PATH
addToPath ~/.config/bin

# The last function call of addToPathFront is at the very front of $PATH
addToPathFront ~/.local/bin
addToPathFront ~/.cargo/bin
addToPathFront ~/.local/pipx/venvs/ansible/bin
addToPathFront ~/Library/Python
addToPathFront /opt/homebrew/bin
