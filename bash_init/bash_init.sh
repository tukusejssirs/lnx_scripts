#!/bin/bash
# Bash files initialisation script

# author:  Tukusej's Sirs
# date:    5 April 2019
# version: 1.3

# TODO:
# - add /etc/skel

binit(){  # $1 must be home directory of a user
	# Variables
	user_home="$1"
	lnx_scripts="$user_home/git/lnx_scripts"

	# Update or clone the repo
	if [ -d $lnx_scripts ]; then
		cwd="$PWD"
		cd $lnx_scripts
		git fetch
		git pull
	else
		mkdir -p $lnx_scripts
		test=$(ssh -T git@github.com 2>&1 | grep -o "You've successfully authenticated")
		if [ "$test" = "You've successfully authenticated" ]; then
			git clone git@github.com:tukusejssirs/lnx_scripts.git $lnx_scripts
		else
			git clone https://github.com/tukusejssirs/lnx_scripts.git $lnx_scripts
		fi
	fi

	if [[ -e $user_home/.bash_aliases ]]; then mv $user_home/.bash_aliases $user_home/.bash_aliases.bak; fi
	if [[ -e $user_home/.bash_profile ]]; then mv $user_home/.bash_profile $user_home/.bash_profile.bak; fi
	if [[ -d $user_home/.bash_progs ]]; then mv $user_home/.bash_progs $user_home/.bash_progs.bak; fi
	if [[ -e $user_home/.bashrc ]]; then mv $user_home/.bashrc $user_home/.bashrc.bak; fi
	if [[ -d $user_home/.bash_functions ]]; then mv $user_home/.bash_functions $user_home/.bash_functions.bak; fi

	ln -s $lnx_scripts/bash_aliases/.bash_aliases $user_home/.bash_aliases
	ln -s $user_home/.bashrc $user_home/.bash_profile
	ln -s $lnx_scripts/bash_progs $user_home/.bash_progs
	ln -s $lnx_scripts/bashrc/.bashrc $user_home/.bashrc
	ln -s $lnx_scripts/bash_functions $user_home/.bash_functions

	if [[ $(uname -r | grep -o "Microsoft$") != "Microsoft" ]]; then
		if [[ -e $user_home/.config/user-dirs.dirs ]]; then mv $user_home/.config/user-dirs.dirs $user_home/.config/user-dirs.dirs.bak; fi
		if [[ -e $user_home/.config/user-dirs.locale ]]; then mv $user_home/.config/user-dirs.locale $user_home/.config/user-dirs.locale.bak; fi
		ln -s $lnx_scripts/user-dirs/user-dirs.dirs $user_home/.config/user-dirs.dirs
		ln -s $lnx_scripts/user-dirs/user-dirs.locale $user_home/.config/user-dirs.locale
	fi
}

users=""
case "$1" in
	all) # For all users
		for u in $(ls /home); do
			test=$(eval echo ~$u)
			if [ "$test" = "/home/$u" ]; then
				# Add user to array
				# users+=" $u"
				binit $test
			fi
		done
		# Add root user to the array
		# users+=" root"
		binit $test
	;;
	"") # Only for current user
		# users="$USER"
		binit $(eval echo ~$USER)
	;;
	*) # For all specified users
		for u in $*; do
			test=$(eval echo ~$u)
			if [ "$test" = "/home/$u" ] || [ "$test" = "/root" ]; then
				# Add user to array
				# users+=" $u"
				binit $test
			fi
		done
	;;
esac