alias src="source ~/.bashrc"  # Reload the ~/.bashrc file
alias back="cd $OLDPWD"  # Move back into previous directory; useful when you change between two different dirs, but useless when going up and down in a directory tree
alias prosby='fdefault="\e[39m" && lred="\e[91m" && lgreen="\e[92m" && lyellow="\e[93m" && lblue="\e[94m" && lmagenta="\e[95m" && smv_i=$(printf "%5s" `ls /home/ts/git_repos/prosby_ocr/txt/smv_i | wc -l`) && smv_ii=$(printf "%6s" `ls /home/ts/git_repos/prosby_ocr/txt/smv_ii | wc -l`) && chckd=$(printf "%5s" `ls /home/ts/git_repos/prosby_ocr/txt/chckd | wc -l`) && todo=$(printf "%4s" $(expr $smv_i + $smv_ii - $chckd)) && total=$(printf "%4s" $(expr $smv_i + $smv_ii + $chckd)) && chckdPer=$(LC_ALL=C /usr/bin/printf "%05.2f\n" $(echo "$chckd * 100 / ($smv_i + $smv_ii)" | bc -l)) && todoPer=$(LC_ALL=C /usr/bin/printf "%05.2f\n" $(echo "$chckd * 100 / ($smv_i + $smv_ii)" | bc -l)) && echo -e "${lyellow}smv_i${fdefault}    ${lred}smv_ii${fdefault}      ${lgreen}chckd${fdefault}            ${lmagenta}todo${fdefault}            ${lblue}total${fdefault}" && echo -e "${lyellow}$smv_i${fdefault}  + ${lred}$smv_ii${fdefault}  -${lgreen}$chckd ($chckdPer %)${fdefault}  = ${lmagenta}$todo ($todoPer %)${fdefault}  ${lblue}$total${fdefault}"'

# git
alias ga="git add --all"
alias gb="git branch"
alias gce="git clean"
alias gcl="git clone"
alias gcm="git commit -am"
alias gmv="git mv"
alias gpl="git pull"
alias gph="git push"
alias grm="git rm"
alias gs="git status"

alias bc="bc -lq"  # Make bc quite (that it does not show the info part every time I run it) and use math library (without it e.g. 5/6 outputs 0; with it 5/6 outputs .83333333333333333333)

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

alias update="sudo apt-get -yq update && sudo apt-get -yq upgrade"