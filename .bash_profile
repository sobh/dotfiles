# We need to do two things here:

# 1. Ensure $HOME/.bash/env gets run first
source $HOME/.config/bash/env

# 2. Prevent it from being run later, since we need to use $BASH_ENV for
# non-login non-interactive shells.
# We don't export it, as we may have a non-login non-interactive shell as
# a child.
BASH_ENV=

# 3. Join the spanish inquisition. ;)
# so much for only two things...

# 4. Run $HOME/.bash/login
. $HOME/.config/bash/login

# 5. Run $HOME/.bash/interactive if this is an interactive shell.
if [ "$PS1" ]; then
	. $HOME/.config/bash/interactive
fi

