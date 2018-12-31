alias src="source ~/.bashrc"  # Reload the ~/.bashrc file
alias back="cd $OLDPWD"  # Move one directory up (seldom used by me, because I use `up` to move a dir up)
alias prosby='fdefault="\e[39m" && lred="\e[91m" && lgreen="\e[92m" && lyellow="\e[93m" && lblue="\e[94m" && lmagenta="\e[95m" && smv_i=$(printf "%5s" `ls /home/ts/git_repos/prosby_ocr/txt/smv_i | wc -l`) && smv_ii=$(printf "%6s" `ls /home/ts/git_repos/prosby_ocr/txt/smv_ii | wc -l`) && chckd=$(printf "%5s" `ls /home/ts/git_repos/prosby_ocr/txt/chckd | wc -l`) && todo=$(printf "%4s" $(expr $smv_i + $smv_ii - $chckd)) && total=$(printf "%4s" $(expr $smv_i + $smv_ii + $chckd)) && chckdPer=$(LC_ALL=C /usr/bin/printf "%05.2f\n" $(echo "$chckd * 100 / ($smv_i + $smv_ii)" | bc -l)) && todoPer=$(LC_ALL=C /usr/bin/printf "%05.2f\n" $(echo "$chckd * 100 / ($smv_i + $smv_ii)" | bc -l)) && echo -e "${lyellow}smv_i${fdefault}    ${lred}smv_ii${fdefault}      ${lgreen}chckd${fdefault}            ${lmagenta}todo${fdefault}            ${lblue}total${fdefault}" && echo -e "${lyellow}$smv_i${fdefault}  + ${lred}$smv_ii${fdefault}  -${lgreen}$chckd ($chckdPer %)${fdefault}  = ${lmagenta}$todo ($todoPer %)${fdefault}  ${lblue}$total${fdefault}"'

# git
alias ga="git add"
alias gb="git branch"
alias gce="git clean"
alias gcl="git clone"
alias gcm="git commit"
alias gmv="git mv"
alias gpl="git pull"
alias gph="git push"
alias grm="git rm"
alias gs="git status"