# Append $PATH with directory
addToPath() {
    if [[ "$PATH" != *"$1"* ]]; then
        export PATH=$PATH:$1
    fi
}

# Prepend $PATH with directory
addToPathFront() {
    if [[ "$PATH" != *"$1"* ]]; then
        export PATH=$1:$PATH
    fi
}

# The last function call of addToPath is at the very end of $PATH
addToPath $HOME/.config/bin

# The last function call of addToPathFront is at the very front of $PATH
addToPathFront $HOME/.local/bin
addToPathFront $HOME/.cargo/bin
addToPathFront $HOME/.local/pipx/venvs/ansible/bin
addToPathFront $HOME/Library/Python
addToPathFront /opt/homebrew/bin
