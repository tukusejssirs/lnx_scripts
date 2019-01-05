# TODO
# - git stuff update scripts [1]
# - .bash_history (auto-update and git push to lnx_*)
# - ls aliases
# - git add + git commit + git push
# - megasync
# - check basic bash settings like shopt (etc)
# - add path to PS1

# [1]
# # update local romcal git repo
# p=$PWD
# cd $HOME/.scripts/romcal
# git fetch && git pull origin && git pull
# cd $p

# Check where we are running the shell (Android/Termux, Linux)
# Then set some system-dependant variables
if [[ `uname -o` == "Android" ]]; then
	if [[ `echo $SHELL` == "/data/data/com.termux/files/usr/bin/login" ]] || [[ `echo $SHELL` == "/data/data/com.termux/files/usr/bin/bash" ]]; then
		# We are in Android/Termux
		usr="/data/data/com.termux/files/usr"
		etc="/data/data/com.termux/files/usr/etc"
		bin="/data/data/com.termux/files/usr/bin"
		var="/data/data/com.termux/files/usr/var"
		dev="/dev"
		alias dateCmd=$(which date)

		# To make `su` work, add `/su/bin/` to $PATH
		PATH=/su/bin:/data/data/com.termux/files/usr/bin:/data/data/com.termux/files/usr/bin/applets
	fi
elif [[ `uname -o` == "GNU/Linux" ]]; then
	usr="/usr"
	etc="/etc"
	bin="/bin"
	var="/var"
	dev="/dev"
	alias dateCmd=$(which date)
fi

# $HOME/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
	*i*) ;;
	*) return;;
esac

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

# Set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r $etc/debian_chroot ]; then
	debian_chroot=$(cat $etc/debian_chroot)
fi

# # If this is an xterm set the title to user@host:dir
case "$TERM" in
	xterm-color|*-256color) color_prompt=yes ;;
esac

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

# Alias definitions.
# You may want to put all your additions into a separate file like
# $HOME/.bash_aliases, instead of adding them here directly.
# See $usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -s $HOME/.bash_aliases ]; then
	test=`file $HOME/.bash_aliases -b`
	grep=`echo $test | grep "^symbolic link" -o`
	path=`echo $test | sed 's/^symbolic link to //' -`

	if [[ $grep == "symbolic link" ]]; then
		. $path
	fi
elif [ -f $HOME/.bash_aliases ]; then
	. $HOME/.bash_aliases
fi

if [ -s $HOME/.bash_functions ]; then
	test=`file $HOME/.bash_functions -b`
	grep=`echo $test | grep "^symbolic link" -o`
	path=`echo $test | sed 's/^symbolic link to \(.*\)\/$/\1/' -`

	if [[ $grep == "symbolic link" ]]; then
		for n in `ls $path`; do
			. $path/$n
		done
	fi
elif [ -d $HOME/.bash_functions ]; then
	. $HOME/.bash_functions/*
	echo ".bash_functions loaded"
fi

if [ -s $HOME/.bash_progs ]; then
	test=`file $HOME/.bash_progs -b`
	grep=`echo $test | grep "^symbolic link" -o`
	path=`echo $test | sed 's/^symbolic link to //' -`

	if [[ $grep == "symbolic link" ]]; then
		. $path
	fi
elif [ -d $HOME/.bash_progs ]; then
	. $HOME/.bash_progs
fi

# Enable programmable completion features
# Note: You don't need to enable this, if it's already enabled in $etc/bash.bashrc and $etc/profile sources /etc/bash.bashrc.
if ! shopt -oq posix; then
  if [ -f $usr/share/bash-completion/bash_completion ]; then
	. $usr/share/bash-completion/bash_completion
  elif [ -f $etc/bash_completion ]; then
	. $etc/bash_completion
  fi
fi

# Format definition
# Note: not every terminal emulator supports all of them
bold="\e[1m"  # This is either bold (if supported) or bright in colour
dim="\e[2m"
italics="\e[3m"
underline="\e[4m"
blink="\e[5m"
overline="\e[6m"
invert="\e[7m"  # Invert the foreground and background colours
hide="\e[8m"  # Change foreground to background colour
strike="\e[9m"  # Strikethrough

# Format and colour reseting
unbold="\e[21m"
undim="\e[22m"
unitalics="\e[23m"
ununderline="\e[24m"
unblink="\e[25m"
unoverline="\e26m"
uninvert="\e[27m"
unhide="\e[28m"
unstrike="\e[9m"
normal="\e[0"  # Normal format (i.e reset all manually set format)
fdefault="\e[39m"  # Default foreground colour
bdefault="\e[49m"  # Default background colour

# Foreground colours (8/16)
black="\e[30m"
red="\e[31m"
green="\e[32m"
yellow="\e[33m"
blue="\e[34m"
magenta="\e[35m"
cyan="\e[36m"
lgrey="\e[37m"
dgrey="\e[90m"
lred="\e[91m"
lgreen="\e[92m"
lyellow="\e[93m"
lblue="\e[94m"
lmagenta="\e[95m"
lcyan="\e[96m"
white="\e[97m"

# Background colours (8/16)
bblack="\e[40m"
bred="\e[41m"
bgreen="\e[42m"
byellow="\e[43m"
bblue="\e[44m"
bmagenta="\e[45m"
bcyan="\e[46m"
blgrey="\e[47m"
bdgrey="\e[100m"
blred="\e[101m"
blgreen="\e[102m"
blyellow="\e[103m"
blblue="\e[104m"
blmagenta="\e[105m"
blcyan="\e[106m"
bwhite="\e[107m"

# prompt
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
	echo -e "${lred}@${fdefault}"
else
	echo "@"
fi

EXIT="$?"  # Return code

if [ $EXIT == 0 ]; then  # $EXIT colour based upon its value
	return="${lred}$retval${fdefault}"
else
	return="${lgreen}$retval${fdefault}"
fi

# Set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r $etc/debian_chroot ]; then
	debian_chroot=$(cat $etc/debian_chroot)
fi

# PS1="${normal}[${purple}\\D{%-l:%M%P}${normal}]${return} ${debian_chroot:+($debian_chroot)}\\u@\\h:\\w\\$ "

t_date=$(dateCmd +"%l.%m%P")

# PS1="\n[${lmagenta}$t_date${fdefault}]\`return_value\` ${debian_chroot:+($debian_chroot)}\u` remote_host`\h: \[\e]0;\w\a\n\\$ "

PS1="\n[${lmagenta}$t_date${fdefault}]\`return_value\` \\u`remote_host`\\h: \\w\n\\$ "

# Unset variables used by .bashrc
unset usr
unset etc
unset bin
unset var
unset date
unset t_date