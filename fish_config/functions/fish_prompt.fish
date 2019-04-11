function fish_prompt --description 'TS Prompt'
	# set colours

	set EXIT $status
	set PS1 ""
	set userHost ""
	#set prompt_demure "$HOME/git/dotfiles/subbash/prompt"

	# Newline
	# Adds a newline after the previous command output (and before the PS1)
	set PS1 $PS1"\n"

	## Date
	set date_format "%l.%M%P"
	set PS1 $PS1"$fdefault[$magenta"(date +"$date_format")"$fdefault]"

	#Exit code
	if [ "$EXIT" != 0 ]
		set PS1 $PS1"$red$EXIT$fdefault"
	else
		set PS1 $PS1"$fdefault$EXIT"
	end

	# Host test
	if [ "$prompt_hostname" = remote-host ]  # TODO: If connected to remote host
		# Remote host
		set nnnn true
	else
		# Local host
		set userHost "$lyellow$USER@"(prompt_hostname)":$fdefault"
	end

	set PS1 $PS1" $userHost$fdefault"

	# Check background and stopped jobs
	# Background running jobs
	set BKGJBS (jobs 2>/dev/null | grep background | wc -l)
	if [ "$BKGJBS" -gt 0 ]
		set PS1 $PS1"$yellow [bg:$BKGJBS]$fdefault"
	end

	# Stopped running jobs
	set STPJBS (jobs 2>/dev/null | grep stopped | wc -l)
	if [ "$STPJBS" -gt 0 ]
		set PS1 $PS1"$yellow [stp:$STPJBS]$fdefault"
	end

	# Git status
	#source <(sed -n '/### Add Git Status/,/### End Git Status/p' $prompt_demure | sed '/### [AdEn]\+ Git St$

	## Inspired by http://www.terminally-incoherent.com/blog/2013/01/14/whats-in-your-bash-prompt/
	if [ (command -v git) ]
		set GStatus (git status --porcelain=2 -b 2>/dev/null | tr '\n' ':')

		if [ -n "$GStatus" ]
			set LAST (stat -c \%Y (git rev-parse --git-dir 2>/dev/null)/FETCH_HEAD 2>/dev/null)
			if [ -n $LAST ]
				set TIME (echo (date +"%s") - $LAST | bc)
				## Check if more than 60 minutes since last run of `${GStatus}`
				if [ $TIME -gt 3600 ]
					git fetch 2>/dev/null
					set PS1 $PS1' +'
					## Refresh var
					set GStatus (git status --porcelain=2 -b 2>/dev/null | tr '\n' ':')
				end
			end
			### End Fetch Check ### }}}

			### Test For Changes ### {{{
			set GChanges (echo $GStatus | tr ':' '\n' | awk 'BEGIN {C=0} /^[12] .M/ {C++} END {print C}')
			if [ "$GChanges" != 0 ]
				set GitColor $lred
			end
			### End Test Changes ### }}}

			### Find Branch ### {{{
			set GBranch (git rev-parse --abbrev-ref HEAD)
			if [ -n "$GBranch" ]
				set GBranch "[$GBranch]"  ## Add brackets for final output
				if [ "$GBranch" = "[master]" ]
					set GBranch "[M]"  ## Just to make it shorter and cleaner
				end
				## Test if in detached head state, and set output to first 8char of hash
				if [ "$GBranch" = "[(detached)]" ]
					set GBranch "("(git rev-parse --short HEAD)")"
				end
			else
				set GBranch "[ERROR]"  ## Could it even happen?
			end
			### End Branch ### }}}

			set PS1 $PS1" $GitColor$GBranch$fdefault"  ## Add result to prompt

			### Find Commit Status ### {{{
			## Test Modified and Untracked for "0"
			# local GDel="$(echo ${GStat} | tr ':' '\n' | grep -c "^[ MARC]D")"

			## Add 0 to knock off the '+'
			set GAhead (echo $GStatus | awk 'match($0,/# branch.ab \+[0-9]+ \-[0-9]+/) {split(substr($0,RSTART+12,RLENGTH-12),s," "); V=s[1]+0} END {if(V>0){print V}}')
			if [ -n "$GAhead" ]
				set PS1 $PS1"$lblue↑$fdefault$GAhead"  ## Local branch is ahead of remote
			end

			## Needs a `git fetch`
			## Multiply by -1 to remove the '-'
			set GBehind (echo $GStatus | awk 'match($0,/# branch.ab \+[0-9]+ \-[0-9]+/) {split(substr($0,RSTART+12,RLENGTH-12),s," "); V=s[2]*-1} END {if(V>0){print V}}')
			if [ -n "$GBehind" ]
				set PS1 $PS1"$lred↓$fdefault$GBehind"  ## Local branch is behind of remote
			end

			## "[ MARC]" comes from https://git-scm.com/docs/git-status
			set GModified (echo $GStatus | tr ':' '\n' | awk 'BEGIN {C=0} /^[12] .M/ {C++} END {print C}')
			if [ "$GModified" -gt "0" ]
				set PS1 $PS1"$lmagenta≠$fdefault$GModified"  ## Local branch contains some modified files
			end

			set GUntracked (echo $GStatus | tr ':' '\n' | awk 'BEGIN {C=0} /^\?/ {C++} END {print C}')
			if [ "$GUntracked" -gt "0" ]
				set PS1 $PS1"$cyan?$fdefault$GUntracked"  ## Local branch contains some untracked files
			end
			### End Commit Status ### }}}
		end
	else
		set MISSING_ITEMS $MISSING_ITEMS"git-prompt, "
end

	# Current working directory (with tilde)
	set home_dir (realpath ~)
	set cwd (pwd | sed "s|$home_dir|~|" -)

	set PS1 $PS1" $cwd\n\$ "  # Currect working directory, newline and \$

	echo -e $PS1
end