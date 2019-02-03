# ogus_init.sh

#!/bin/bash
# First, you need to install Termux, termux-tasker, and Tasker (e.g. from Google Play)

# Install dependencies
apt-get -yq install coreutils grep sed curl jq wget ncurses-utils
mkdir -p $HOME/.git
git clone https://gitlab.com/st42/termux-sudo.git $HOME/.git/termux-sudo
# Note: For some reason, in the following command, the first file must have an absolute path
ln -s $PWD/.git/termux-sudo/sudo /data/data/com.termux/files/usr/bin/sudo
chmod 700 /data/data/com.termux/files/usr/bin/sudo
git clone https://github.com/tukusejssirs/lnx_scripts.git $HOME/.git/lnx_scripts

# Create directory for Tasker (and termux-tasker) accessible scripts
mkdir -p $HOME/.termux/tasker

# Symlink ogus.sh to tasker directory
ln -s $PWD/.git/lnx_scripts/bash_functions/termux/ogus.sh $HOME/.termux/tasker/ogus.sh

# Lastly, you need to create Tasker profile
# (1) Open Tasker
# (2) Switch to Profiles
# (3) Long-tap on Profiles tab name
# (4) Tap on Import
# (5) Locate the Tasker profile (ogus_cron.prf.xml)
# (6) Import it
# (7) Activate it