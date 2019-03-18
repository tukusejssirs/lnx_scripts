# Bash files initialisation script
# version: 1.2

#!/bin/bash
lnx_scripts=$(dirname $(dirname $(realpath $PWD/$0)))

if [[ -e $HOME/.bash_aliases ]]; then mv $HOME/.bash_aliases $HOME/.bash_aliases.bak; fi
if [[ -e $HOME/.bash_profile ]]; then mv $HOME/.bash_profile $HOME/.bash_profile.bak; fi
if [[ -d $HOME/.bash_progs ]]; then mv $HOME/.bash_progs $HOME/.bash_progs.bak; fi
if [[ -e $HOME/.bashrc ]]; then mv $HOME/.bashrc $HOME/.bashrc.bak; fi
if [[ -d $HOME/.bash_functions ]]; then mv $HOME/.bash_functions $HOME/.bash_functions.bak; fi

ln -s $lnx_scripts/bash_aliases/.bash_aliases $HOME/.bash_aliases
ln -s $HOME/.bashrc $HOME/.bash_profile
ln -s $lnx_scripts/bash_progs $HOME/.bash_progs
ln -s $lnx_scripts/bashrc/.bashrc $HOME/.bashrc
ln -s $lnx_scripts/bash_functions $HOME/.bash_functions

if [[ $(uname -r | grep -o "Microsoft$") != "Microsoft" ]]; then
	if [[ -e $HOME/.config/user-dirs.dirs ]]; then mv $HOME/.config/user-dirs.dirs $HOME/.config/user-dirs.dirs.bak; fi
	if [[ -e $HOME/.config/user-dirs.locale ]]; then mv $HOME/.config/user-dirs.locale $HOME/.config/user-dirs.locale.bak; fi
	ln -s $lnx_scripts/user-dirs/user-dirs.dirs $HOME/.config/user-dirs.dirs
	ln -s $lnx_scripts/user-dirs/user-dirs.locale $HOME/.config/user-dirs.locale
fi