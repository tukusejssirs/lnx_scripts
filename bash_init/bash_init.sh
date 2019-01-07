# Bash files initialisation script
# version: 1.0

#!/bin/bash
if [[ -e $HOME/.bash_aliases ]]; then mv $HOME/.bash_aliases $HOME/.bash_aliases.orig; fi
if [[ -e $HOME/.bash_profile ]]; then mv $HOME/.bash_profile $HOME/.bash_profile.orig; fi
if [[ -e $HOME/.bash_progs ]]; then mv $HOME/.bash_progs $HOME/.bash_progs.orig; fi
if [[ -e $HOME/.bashrc ]]; then mv $HOME/.bashrc $HOME/.bashrc.orig; fi
if [[ -e $HOME/.bash_functions ]]; then mv $HOME/.bash_functions $HOME/.bash_functions.orig; fi

ln -s $HOME/git/lnx_scripts/bash_aliases/.bash_aliases $HOME/.bash_aliases
ln -s $HOME/.bashrc $HOME/.bash_profile
ln -s $HOME/git/lnx_scripts/bash_progs/.bash_progs $HOME/.bash_progs
ln -s $HOME/git/lnx_scripts/bashrc/.bashrc $HOME/.bashrc
ln -s $HOME/git/lnx_scripts/bashrc/.bash_functions $HOME/.bash_functions
