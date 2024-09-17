# dotfiles for macOS (Apple silicon)

- Configured for personal use with ansible, git and stow. WIP.

## Commands to run in terminal:

1. `export PATH="/opt/homebrew/bin:~/.local/bin:$PATH"` As long the same window is kept open, the directories for homebrew
   and ansible can be found after installation. The actual duplicate-free export PATHs are done with function calls introduced via step 4.

2. `xcode-select --install` This is required for `git clone` later on.

3. `sudo visudo` This opens the sudoers file. Just exit immediately. This command needs to be run at least once for
   the playbook's sudoers task to not trigger the "sudo needs password" error.

4. `bash -c "$(curl -fsSL https://raw.githubusercontent.com/softr4in/.dotfiles/main/shell_config/.config/scripts/first_run.sh)"` This is the script to bootstrap everything.

## Observations so far on fresh macOS install:

- ansible's responsibilities have been downgraded (until I figure out a better way to do things) from:
    - installer of most packages to checker of installed packages. It's just too slow and buggy; far better to run good old bash scripts.
        - ansible's community.general.homebrew module gets stuck once while installing packages.
        - ansible's community.general.homebrew_casks module is very slow and gets stuck multiple times while installing packages.
        - Therefore, it is faster and smoother to install homebrew formulas and casks via `brew install bundle` for the foreseeable future.
    - ~~installer of macos defaults~~
        - I can't seem to get the macos defaults script to run properly via the playbook. The task reports as successfully run
          without actually setting any defaults.
