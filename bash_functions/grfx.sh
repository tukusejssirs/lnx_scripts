# This function removes `origin` remote and re-adds it. Probably only in git v2.19.1, sometimes it happens it cannot fetch new branches (and probably anything)

# author:  Tukusej's Sirs
# date:    20 March 2019
# version: 1.0

function grfx(){
	local origin=$(git remote -v | grep origin.*fetch | awk '{print $2}')
	git remote rm origin
	git remote add origin "$origin"
}