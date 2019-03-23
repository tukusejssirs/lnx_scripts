function fish_prompt --description 'TS Prompt'
	# set colours

	set EXIT $status
	set PS1 ""
	set userHost ""
        set prompt_demure "$HOME/git/dotfiles/subbash/prompt"

	# Newline
	# Adds a newline after the previous command output (and before the PS1)
	set PS1 $PS1"\n"

	## Date
	set date_format "%l.%M%P"
	set PS1 $PS1"[$magenta"(date +"$date_format")"$fdefault]"

	# Exit code
	if [ $EXIT != 0 ]
		set PS1 $PS1"$red$EXIT$fdefault"
	else
		set PS1 $PS1"z$fdefault$EXIT"
	end

	### Host test
	if [ $prompt_hostname == 'remote-host' ]  # TODO: If connected to remote host
		# Remote host
		set nnnn true
	else
		# Local host
		set userHost "$lyellow$USER@"(prompt_hostname)":$fdefault"
	endf

	set PS1 $PS1" $userHost$fdefault"

	# Check background and stopped jobs
	# Background running jobs
	set BKGJBS (jobs 2>/dev/null | grep stopped | wc -l)
	if [ $BKGJBS -gt 0 ]
		set PS1 $PS1"$yellow \[bg:$BKGJBS\]$fdefault"
	end

	echo -e $PS1
end