# ls, grep aliases
# TODO: find my old ls aliases
# enable color support of ls and also add handy aliases
if [ -x $usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
	alias ls='ls --color=auto'
	alias ll='ls -AlhF --color=auto'
	alias la='ls -lhA --color=auto'
	alias l='ls -CF --color=auto'
	alias lh='ls -Alh --color=auto'
fi

# Coloured GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# shell aliases
# Reload the $HOME/.bashrc file
alias srcb="source $HOME/.bashrc"
# Move back into previous directory; useful when you change between two different dirs, but useless when going up and down in a directory tree
alias back="cd $OLDPWD"

# git aliases
alias ga="git add"  # Stage selected files
alias gaa="git add --all"  # Stage all files/folders (new/modified/deleted)
alias gb="git branch"  # Without any arg/options, list all local branches
alias gba="git branch -a"  # Without any arg/options, list all local and remote branches
alias gbav="git branch -av"  # Without any arg/options, list all local and remote branches verbously
alias gbc="git rev-parse --abbrev-ref HEAD"  # Output current branch name
alias gbr="git branch -r"  # Without any arg/options, list all remote branches
alias gbrv="git branch -rv"  # Without any arg/options, list all remote branches verbously
alias gbv="git branch -v"  # Without any arg/options, list all local branches verbously
alias gce="git clean"  # Remove untracked files from the working tree
alias gcfe="git config --global user.email"  # Set $1 as git global email address
alias gcfg="git config"  # Used to set or get git config
alias gcfn="git config --global user.name"  # Set $1 as git global name
alias gcl="git clone"  # Clone a remote repo
alias gcm="git commit -m"  # Create a commit with a message $1
alias gco="git checkout"  # Check out to branch $1
alias gcom="git checkout master"  # Check out to master branch
alias gdiff="git diff"  # Show differences between HEAD files and files in CWD; if any arg specified, show only those files
alias gf="git fetch"  # Update git data from remote (default: origin)
alias gfom="git fetch origin master"  # Fetch data/files from master (or different the tracked?) branch
alias gfu="git fetch upstream"  # Update git data from upstream
alias gl1="git log --pretty=oneline"  # Show git log with full commit hashes and messages
alias gl1s="git log --pretty=oneline --abbrev-commit"  # Same as `gl1`, only with short hashes
alias gl="git log"  # Show git log (full commit hashes and messages with author and date)
alias glg='git log --pretty=format:"%h %s" --graph'  # Same as `gl1s`, but with graphical representation of commit history
alias gmg="git merge"  # Merge branch $1
alias gmgs="git merge --squash"  # Merge branch $1 without commit history and without commiting anything
alias gmv="git mv"  # Move specified files
alias gph="git push"  # Push committed files/folders to remote (default: origin)
alias gpl="git pull"  # Pull committed files/folders from remote (default: origin)
alias gplu="git pull upstream"  # Pull committed files/folders from upstream branch $1
alias gr="git remote"  # Used to get/set remotes; without any args: list remotes
alias grau="git remote add upstream"  # Add remote url $1 of the main repo to the fork repo to sync
alias grm="git rm"  # Remove files (in CWD)
alias grmr="git reset HEAD --"  # Remove changes from CWD (reset it to HEAD / last commit in the branch)
alias grms="git rm --cached"  # Remove changes (selected files/folders) from stage
alias grv="git remote -v"  # List remotes with urls
alias gs="git status"  # Show staged and non-staged files

# Add an "alert" alias for long running commands. Use like so:
# sleep 10; alert
# Note: Needs `libnotify-bin` package
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Make bc quite (that it does not show the info part every time I run it) and use math library (without it e.g. 5/6 outputs 0; with it 5/6 outputs .83333333333333333333)
alias bc="bc -lq"

# git repos update
alias trupd8="make clean && make && smake PREFIX=$usr install"

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

# ftp
if [[ -e $HOME/.mm.cz/ftp ]]; then
	alias mm="lftp -u mrtvamanzelkacz,$(<$HOME/.mm.cz/ftp) ftpx.forpsi.com"
fi