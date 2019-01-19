# Bash files initialisation script
# version: 1.1

#!/bin/bash
script_dir=$(pwd)/..

if [[ -e $HOME/.bash_aliases ]]; then mv $HOME/.bash_aliases $HOME/.bash_aliases.bak; fi
if [[ -e $HOME/.bash_profile ]]; then mv $HOME/.bash_profile $HOME/.bash_profile.bak; fi
if [[ -e $HOME/.bash_progs ]]; then mv $HOME/.bash_progs $HOME/.bash_progs.bak; fi
if [[ -e $HOME/.bashrc ]]; then mv $HOME/.bashrc $HOME/.bashrc.bak; fi
if [[ -e $HOME/.bash_functions ]]; then mv $HOME/.bash_functions $HOME/.bash_functions.bak; fi
if [[ -e $HOME/.config/user-dirs.dirs ]]; then mv $HOME/.config/user-dirs.dirs $HOME/.config/user-dirs.dirs.bak; fi
if [[ -e $HOME/.config/user-dirs.locale ]]; then mv $HOME/.config/user-dirs.locale $HOME/.config/user-dirs.locale.bak; fi

ln -s $script_dir/bash_aliases/.bash_aliases $HOME/.bash_aliases
ln -s $HOME/.bashrc $HOME/.bash_profile
ln -s $script_dir/bash_progs/.bash_progs $HOME/.bash_progs
ln -s $script_dir/bashrc/.bashrc $HOME/.bashrc
ln -s $script_dir/bashrc/.bash_functions $HOME/.bash_functions
ln -s $script_dir/user-dirs/user-dirs.dirs $HOME/.config/user-dirs.dirs
ln -s $script_dir/user-dirs/user-dirs.locale $HOME/.config/user-dirs.locale