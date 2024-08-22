# NOTE: `.zshenv` is sourced on all invocations of the shell, unless the -f option is set
# `.zshenv` should not have commands that produce output or assume the shell is attached to a tty.
# In practice, `.zshenv` is less performant and less secure than .zprofile.

# leaving this blank unless something changes my mind.

# Begin added by argcomplete
fpath=( /Users/trisyong/.local/pipx/venvs/argcomplete/lib/python3.12/site-packages/argcomplete/bash_completion.d "${fpath[@]}" )
# End added by argcomplete
