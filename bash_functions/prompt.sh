# Prompt Settings of Tukusej's Sirs

# author:  Tukusej's Sirs
# date:    15 March 2019
# version: 1.1

# Based upon multiple online sources, esp on demuredemeanor's bashrc sub source prompt script (https://notabug.org/demure/dotfiles/raw/master/subbash/prompt)

# ps1=
# "\n
# [time]? user@host: [bg:n] [stp:n] [git] cwd\n
# $ "

# \n - newline
# ${lmagenta} - light magenta (colour)
# ${fdefault} - default/normal colour
# $EXIT - variable of coloured exit code value
# \u - current user name
# $at - variable of a "@" that is either red (if the host is remote), otherwise in normal colour
# \h -  host name
# \w - current working directory
# \$ - if user is user 0 (root), displays "#", otherwise "$"
# [other chars] - literal text

# This changes the PS1
export PROMPT_COMMAND=prompt

function prompt(){
	local EXIT="$?"  # This needs to be first
	PS1=""
	local userHost=""
	local prompt_demure="$HOME/git/dotfiles/subbash/prompt"

	# Newline
	# Adds a newline after the previous command output (and before the PS1)
	PS1+="\n"

	## Date
	PS1+="${fdefault}[${magenta}\D{%l.%M%P}${fdefault}]"

	# Exit code
	if [ $EXIT != 0 ]; then
		PS1+="${red}${EXIT}${fdefault}"
	else
		PS1+="${fdefault}${EXIT}"
	fi

	### Host test
	if [ $HOSTNAME == 'remote-host' ]; then  # TODO: If connected to remote host
		# Remote host
		nnnn=true
	else
		# Local host
		local userHost="${lyellow}\u@\h:${fdefault}"
	fi

	PS1+=" ${userHost}${fdefault}"

	# Check background and stopped jobs
	# Background running jobs
	local BKGJBS=$(jobs -r | wc -l | tr -d ' ')
	if [ ${BKGJBS} -gt 0 ]; then
		PS1+="${yellow}[bg:${BKGJBS}]${fdefault}"
	fi

	## Stopped jobs
	local STPJBS=$(jobs -s | wc -l | tr -d ' ')
	if [ ${STPJBS} -gt 0 ]; then
		PS1+=" ${yellow}[stp:${STPJBS}]${fdefault}"
	fi

	# Git status
	source <(sed -n '/### Add Git Status/,/### End Git Status/p' $prompt_demure | sed '/### [AdEn]\+ Git Status ### [{}]\+/d' - | sed 's/"${GChanges}" == "0"/"${GChanges}" != "0"/' - | sed '/local GitColor=\$Gre/,+1 d' - | sed 's/## Check if more than 60 minutes since last/## Check if more than 60 minutes since last run of `${GStatus}`/' - | sed 's/$[{]*Red[}]*/${lred}/g' - | sed 's/$[{]*RCol[}]*/${fdefault}/g' - | sed 's/$[{]*Gre[}]*/${lblue}/g' - | sed 's/$[{]*Pur[}]*/${lmagenta}/g' - | sed 's/$[{]*Yel[}]*/${cyan}/g' -)

	# Current working Directory
	local cwd=$(realpath "$PWD" | sed "s|/mnt/c/Users/ts|~|;s|$HOME|~|" -)

	PS1+=" $cwd\n\$ "  # Currect working directory, newline and \$
}