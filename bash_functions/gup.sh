#!/bin/bash
function gup(){
	msg="$@"
	test=`gs | tail -1`
	okay="nothing to commit, working tree clean"

	if [[ $test == $okay ]]; then
		return $okay
	else
		git add --all
		git commit -am $msg
		git push
	fi
}