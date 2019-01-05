# ls, grep aliases
# TODO: find my old ls aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Coloured GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# shell aliases
alias src="source $HOME/.bashrc"  # Reload the $HOME/.bashrc file
alias back="cd $OLDPWD"  # Move one directory up (seldom used by me, because I use `up` to move a dir up)

# progress aliases
alias prosby='fdefault="\e[39m" && lred="\e[91m" && lgreen="\e[92m" && lyellow="\e[93m" && lblue="\e[94m" && lmagenta="\e[95m" && smv_i=$(printf "%5s" `ls $HOME/git/prosby_ocr/txt/smv_i | wc -l`) && smv_ii=$(printf "%6s" `ls $HOME/git/prosby_ocr/txt/smv_ii | wc -l`) && chckd=$(printf "%5s" `ls $HOME/git/prosby_ocr/txt/chckd | wc -l`) && todo=$(printf "%4s" $(expr $smv_i + $smv_ii - $chckd)) && total=$(printf "%4s" $(expr $smv_i + $smv_ii + $chckd)) && chckdPer=$(LC_ALL=C /usr/bin/printf "%05.2f\n" $(echo "$chckd * 100 / ($smv_i + $smv_ii)" | bc -l)) && todoPer=$(LC_ALL=C /usr/bin/printf "%05.2f\n" $(echo "$chckd * 100 / ($smv_i + $smv_ii)" | bc -l)) && echo -e "${lyellow}smv_i${fdefault}    ${lred}smv_ii${fdefault}      ${lgreen}chckd${fdefault}            ${lmagenta}todo${fdefault}            ${lblue}total${fdefault}" && echo -e "${lyellow}$smv_i${fdefault}  + ${lred}$smv_ii${fdefault}  -${lgreen}$chckd ($chckdPer %)${fdefault}  = ${lmagenta}$todo ($todoPer %)${fdefault}  ${lblue}$total${fdefault}"'

# git aliases
alias ga="git add"
alias gb="git branch"
alias gce="git clean"
alias gcl="git clone"
alias gcm="git commit -am"
alias gmv="git mv"
alias gpl="git pull"
alias gph="git push"
alias grm="git rm"
alias gs="git status"

# apt aliases
alias upgrade="sudo apt-get -yq update && sudo apt-get -yq --with-new-pkgs upgrade

# Add an "alert" alias for long running commands. Use like so:
# sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|se$