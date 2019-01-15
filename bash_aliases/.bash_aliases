# ls, grep aliases
# TODO: find my old ls aliases
# enable color support of ls and also add handy aliases
if [ -x $usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias ls='ls --color=auto'
	alias ll='ls -alF --color=auto'
	alias la='ls -A --color=auto'
	alias l='ls -CF --color=auto'
fi

# Coloured GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# shell aliases
# Reload the $HOME/.bashrc file
alias srcb="source $HOME/.bashrc"
# Move back into previous directory; useful when you change between two different dirs, but useless when going up and down in a directory tree
alias back="cd $OLDPWD"

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

# Add an "alert" alias for long running commands. Use like so:
# sleep 10; alert
# Note: Needs `libnotify-bin` package
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Make bc quite (that it does not show the info part every time I run it) and use math library (without it e.g. 5/6 outputs 0; with it 5/6 outputs .83333333333333333333)
alias bc="bc -lq"

# trans (this takes some time to load)
for n in {af,am,ar,az,ba,be,bg,bn,bs,ca,ceb,co,cs,cy,da,de,el,emj,en,eo,es,et,eu,fa,fi,fj,fr,fy,ga,gd,gl,gu,ha,haw,he,hi,hmn,hr,ht,hu,hy,id,ig,is,it,ja,jv,ka,kk,km,kn,ko,ku,ky,la,lb,lo,lt,lv,mg,mhr,mi,mk,ml,mn,mr,mrj,ms,mt,mww,my,ne,nl,no,ny,otq,pa,pap,pl,ps,pt,ro,ru,sd,si,sk,sl,sm,sn,so,sq,sr-cyrl,sr-latn,st,su,sv,sw,ta,te,tg,th,tl,tlh,tlh-qaak,to,tr,tt,ty,udm,uk,ur,uz,vi,xh,yi,yo,yua,yue,zh-cn,zh-tw,zu}; do

	for m in {af,am,ar,az,ba,be,bg,bn,bs,ca,ceb,co,cs,cy,da,de,el,emj,en,eo,es,et,eu,fa,fi,fj,fr,fy,ga,gd,gl,gu,ha,haw,he,hi,hmn,hr,ht,hu,hy,id,ig,is,it,ja,jv,ka,kk,km,kn,ko,ku,ky,la,lb,lo,lt,lv,mg,mhr,mi,mk,ml,mn,mr,mrj,ms,mt,mww,my,ne,nl,no,ny,otq,pa,pap,pl,ps,pt,ro,ru,sd,si,sk,sl,sm,sn,so,sq,sr-cyrl,sr-latn,st,su,sv,sw,ta,te,tg,th,tl,tlh,tlh-qaak,to,tr,tt,ty,udm,uk,ur,uz,vi,xh,yi,yo,yua,yue,zh-cn,zh-tw,zu}; do

		if [[ $n != $m ]]; then
			aliasName="tr"$n$m
			if [[ $n = "tlh" ]] || [[ $m = "tlh" ]] || [[ $n = "tlh-qaak" ]] || [[ $m = "tlh-qaak" ]] || [[ $n = "otq" ]] || [[ $m = "otq" ]]; then
				alias $aliasName="trans -e bing $n:$m"
			elif [[ $n = "emj" ]] || [[ $m = "emj" ]]; then
				alias $aliasName="trans -e yandex $n:$m"
			else
				alias $aliasName="trans $n:$m"
			fi
		fi
	done
done
