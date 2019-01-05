# Bash files initialisation script
# version: 1.0

#!/bin/bash
mv $HOME/.bash_aliases $HOME/.bash_aliases.orig
mv $HOME/.bash_profile $HOME/.bash_profile.orig
mv $HOME/.bash_progs $HOME/.bash_progs.orig
mv $HOME/.bashrc $HOME/.bashrc.orig

ln -s $HOME/git/lnx_scripts/bash_aliases/.bash_aliases $HOME/.bash_aliases
ln -s $HOME/.bashrc $HOME/.bash_profile
ln -s $HOME/git/lnx_scripts/bash_progs/.bash_progs $HOME/.bash_progs
ln -s $HOME/git/lnx_scripts/bashrc/.bashrc $HOME/.bashrc