# TODO
# - git stuff update scripts [1]
# - .bash_history (auto-update and git push to lnx_*)
# - ls aliases
# - git add + git commit + git push
# - megasync
# - check basic bash settings like shopt (etc)
# - add path to PS1
# - check if terminal supports colours (in bash_functions/bash_colours.sh)
# - prompt: if logged in locally:  [user of  local host]@[local  host]
# - prompt: if logged in remotely: [user of remote host]@[remote host]

# [1]
# # update local romcal git repo
# p=$PWD
# cd $HOME/.scripts/romcal
# git fetch && git pull origin && git pull
# cd $p

# Check where we are running the shell (Android/Termux, Linux)
# Then set some system-dependant variables
if [[ $(uname -o) == "Android" ]]; then
	if [[ $(echo $SHELL) == "/data/data/com.termux/files/usr/bin/login" ]] || [[ $(echo $SHELL) == "/data/data/com.termux/files/usr/bin/bash" ]]; then
		# We are in Android/Termux
		usr="/data/data/com.termux/files/usr"
		etc="/data/data/com.termux/files/usr/etc"
		bin="/data/data/com.termux/files/usr/bin"
		var="/data/data/com.termux/files/usr/var"
		dev="/dev"

		# To make `su` work, add `/su/bin/` to $PATH
		PATH=/su/bin:/data/data/com.termux/files/usr/bin:/data/data/com.termux/files/usr/bin/applets

		# apt aliases
		alias upgrade="apt-get -yq update && apt-get -yq --with-new-pkgs upgrade"
		alias install="apt-get -yq install"
		alias ogup="$HOME/git/lnx_scripts/bash_functions/termux/ogup.sh"
	fi
elif [[ $(uname -o) == "GNU/Linux" ]]; then
	# apt aliases
	alias upgrade="sudo apt-get -yq update && sudo apt-get -yq --with-new-pkgs upgrade"
	alias install="sudo apt-get -yq install"

	usr="/usr"
	etc="/etc"
	bin="/bin"
	var="/var"
	dev="/dev"

	if [[ $(uname -r | grep -o "Microsoft$") == "Microsoft" ]]; then
		# Support of Linux permissions in the WSL
		#cwd=$PWD
		# cd /  # Change to dir outside /mnt/c (or the symlink to it)
		# sudo umount /mnt/c && sudo mount -t drvfs C: /mnt/c -o metadata  # Remount /mnt/c with linux perms support
		# cd $cwd  # Enter the home dir when started

		# Functions to run MS Windows apps
		# TODO:
		# - create one function for all of these; ideally all from the win path
		# - make it work with `sudo`
		# - move them to `bash_functions/` dir and source them in `.bashrc`
		function indi(){
			file=$(wslpath -aw $1)
			/mnt/c/Program\ Files/Adobe/Adobe\ InDesign\ CC\ 2018/InDesign.exe "$file"
		}

		function ff(){
			file=$(wslpath -aw $1)
			/mnt/c/Program\ Files/Mozilla\ Firefox/firefox.exe "$file"
		}

		function subl(){
			file=$(wslpath -aw $1)
			/mnt/c/Program\ Files/Sublime\ Text\ 3/sublime_text.exe "$file"
		}
	fi
fi

# $HOME/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
# Setting HISTSIZE to a value less than zero causes the history list to be unlimited (setting it 0 zero disables the history list).
# Setting HISTFILESIZE to a value less than zero causes the history file size to be unlimited (setting it to 0 causes the history file to be truncated to zero size).
HISTSIZE=-1
HISTFILESIZE=-1

# Check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will match all files and zero or more directories and subdirectories.
shopt -s globstar

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x $usr/bin/lesspipe ] && eval "$(SHELL=$bin/sh lesspipe)"

# Coloured GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

if [ -n "$force_color_prompt" ]; then
	if [ -x $usr/bin/tput ] && tput setaf 1 >&$dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
	else
	color_prompt=
	fi
fi

# Add an "alert" alias for long running commands. Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Files sourcing ##############################################################

# See $usr/share/doc/bash-doc/examples in the bash-doc package.
### Interactive ### {{{
if [[ $- == *i* ]]; then
	path_fn="$HOME/git/lnx_scripts/bash_functions"
	# 'Source' function
	source $path_fn/src.sh

	# Bash colours
	src $path_fn/bash_colours.sh

	# Bash aliases
	src $HOME/.bash_aliases

	# Bash functions
	src $path_fn/add_ssh_keys.sh
	src $path_fn/cconv.sh
	src $path_fn/char_multiplier.sh
	src $path_fn/create_ssh_keys.sh
	src $path_fn/cue2cd.sh
	src $path_fn/fram.sh
	src $path_fn/gls.sh
	src $path_fn/gup.sh
	src $path_fn/mkcd.sh
	src $path_fn/prompt.sh
	src $path_fn/prosby.sh
	src $path_fn/round.sh
	src $path_fn/scan.sh
	src $path_fn/up.sh

	# Bash programs
	src $HOME/.bash_progs
fi

# Enable programmable completion features
# Note: You don't need to enable this, if it's already enabled in $etc/bash.bashrc and $etc/profile sources /etc/bash.bashrc.
if ! shopt -oq posix; then
  if [ -f $usr/share/bash-completion/bash_completion ]; then
	src $usr/share/bash-completion/bash_completion
  elif [ -f $etc/bash_completion ]; then
	src $etc/bash_completion
  fi
fi

# ssh
eval `ssh-agent -s` &> /dev/null
for n in `ls $HOME/.ssh/*.pub | sed 's/\.pub//g' -`; do
	ssh-add -q $n &> /dev/null
done