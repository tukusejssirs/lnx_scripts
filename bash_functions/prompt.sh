# Prompt Settings of Tukusej's Sirs
# version 1.0

# Based upon multiple online sources, esp on demuredemeanor's bashrc sub source prompt script (https://notabug.org/demure/dotfiles/raw/master/subbash/prompt)

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

    ### Colors to Vars ### {{{
    ## Inspired by http://wiki.archlinux.org/index.php/Color_Bash_Prompt#List_of_colors_for_prompt_and_Bash
    ## Terminal Control Escape Sequences: http://www.termsys.demon.co.uk/vtansi.htm
    ## Consider using some of: https://gist.github.com/bcap/5682077#file-terminal-control-sh
    ## Can unset with `unset -v {,B,U,I,BI,On_,On_I}{Bla,Red,Gre,Yel,Blu,Pur,Cya,Whi} RCol`

    # ps1=
	# "\n
	# [time]? user@host: [bg:n] [stp:n] cwd\n
	# $ "

	## Newline
	## Adds a newline after the previous command output (and before the PS1)
	PS1+="\n"

    ## Date
    PS1+="[${magenta}\D{%l.%M%P}${fdefault}]"

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

# export PS1="\n[${lmagenta}\D{%l.%m%P}${fdefault}]$(EXIT="$?"; if [[ EXIT == 0 ]]; then echo "${?}"; else echo "${lred}${?}${fdefault}"; fi) \u@\h: \w\n\$ "

# function exit_value(){ EXIT="$?"; if [[ $EXIT == "0" ]]; then echo -e "$EXIT"; else echo -e "${red}$EXIT${normal}"; fi }; export PS1="\n$(exit_value)\n\$"

# ps1=
# "\n
# [time]? user@host: [bg:n] [stp:n] [git] cwd\n
# $ "

    PS1+=" ${userHost}${fdefault}"

    ### Check background and stopped jobs
    # command jobs 2>/dev/null
    # if [ $? == "0" ]; then
        ## Background running jobs
        local BKGJBS=$(jobs -r | wc -l | tr -d ' ')
        if [ ${BKGJBS} -gt 0 ]; then
            PS1+="${yellow}[bg:${BKGJBS}]${fdefault}"
        fi

        ## Stopped jobs
        local STPJBS=$(jobs -s | wc -l | tr -d ' ')
        if [ ${STPJBS} -gt 0 ]; then
            PS1+=" ${yellow}[stp:${STPJBS}]${fdefault}"
        fi
    # fi

    ### Add Git Status ### {{{
    ## Inspired by http://www.terminally-incoherent.com/blog/2013/01/14/whats-in-your-bash-prompt/
    if [[ $(command -v git) ]]; then
        local GStat="$(git status --porcelain -b 2>/dev/null | tr '\n' ':')"

        if [ "$GStat" ]; then
            ### Fetch Time Check ### {{{
            local LAST=$(stat -c %Y $(git rev-parse --git-dir 2>/dev/null)/FETCH_HEAD 2>/dev/null)
            if [ "${LAST}" ]; then
                local TIME=$(echo $(date +"%s") - ${LAST} | bc)
                ## Check if more than 60 minutes since last
                if [ "${TIME}" -gt "3600" ]; then
                    git fetch 2>/dev/null
                    PS1+=' +'
                    ## Refresh var
                    local GStat="$(git status --porcelain -b 2>/dev/null | tr '\n' ':')"
                fi
            fi

            ### Test For Changes ### {{{
            ## Change this to test for 'ahead' or 'behind'!
            local GChanges="$(echo ${GStat} | tr ':' '\n' | grep -v "^$" | grep -v "^\#\#" | wc -l | tr -d ' ')"
            if [[ "$GChanges" != "0" ]]; then
                local GitCol=${red}
            fi
            ### End Test Changes ### }}}

            ### Find Branch ### {{{
            local GBra="$(echo ${GStat} | tr ':' '\n' | grep "^##" | cut -c4- | grep -o "^[a-zA-Z]\{1,\}[^\.]")"
            if [ "$GBra" ]; then
                if [ "$GBra" == "master" ]; then
                    local GBra="M"      ## Just to make it shorter
                fi
              else
                local GBra="ERROR"      ## Could it ever happen?
            fi
            ### End Branch ### }}}

            PS1+=" ${GitCol}[$GBra]${fdefault}" ## Add result to prompt

            ### Find Commit Status ### {{{
            local GAhe="$(echo ${GStat} | tr ':' '\n' | grep "^##" | grep -o "ahead [0-9]\{1,\}" | grep -o "[0-9]\{1,\}")"
            if [ "$GAhe" ]; then
                PS1+="${lblue}↑${fdefault}${GAhe}"    ## Ahead
            fi

            ## Needs a `git fetch`
            local GBeh="$(echo ${GStat} | tr ':' '\n' | grep "^##" | grep -o "behind [0-9]\{1,\}" | grep -o "[0-9]\{1,\}")"
            if [ "$GBeh" ]; then
                PS1+="${lred}↓${fdefault}${GBeh}"    ## Behind
            fi

            local GMod="$(echo ${GStat} | tr ':' '\n' | grep -c "^[ MARC]M")"
            if [ "$GMod" -gt "0" ]; then
                PS1+="${magenta}≠${fdefault}${GMod}"    ## Modified
            fi

            local GUnt="$(echo ${GStat} | tr ':' '\n' | grep -c "^\?")"
            if [ "$GUnt" -gt "0" ]; then
                PS1+="${yellow}?${fdefault}${GUnt}"    ## Untracked
            fi
            ### End Commit Status ### }}}
        fi
    fi
    ### End Git Status ### }}}

    PS1+=" \w\n\$ "  # Currect working directory, newline and \$

    # PS1+=" ${PSCol}${fdefault}"          ## End of PS1
}
### End PS1 ### }}}
