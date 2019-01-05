#!/bin/bash
function remote_host(){
	if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
		echo -e "${lred}@${fdefault}"
	else
		echo "@"
	fi
}

function prompt(){
	local EXIT="$?"  # Return code
	PS1=""

	if [ $EXIT == 0 ]; then  # $EXIT colour based upon its value
		local return="${lred}$retval${fdefault}"
	else
		local return="${lgreen}$retval${fdefault}"
	fi

	# Set variable identifying the chroot you work in (used in the prompt below)
	if [ -z "${debian_chroot:-}" ] && [ -r $etc/debian_chroot ]; then
		debian_chroot=$(cat $etc/debian_chroot)
	fi

	PS1="${normal}[${purple}\\D{%-l:%M%P}${normal}]${return} ${debian_chroot:+($debian_chroot)}\\u@\\h:\\w\\$ "

	# PS1="\n[${green}$t_date${fdefault}]\`return_value\` ${debian_chroot:+($debian_chroot)}\u`remote_host`\h: \[\e]0;\w\a\n\\$ "

	#export PROMPT_COMMAND=prompt
}