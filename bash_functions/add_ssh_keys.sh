#!/bin/bash

# Add ssh keys
# TODO: make a function from this
function add_ssh_keys(){
	eval `ssh-agent -s` &>/dev/null
	keys=`ls ~/.ssh | grep \.pub | sed 's/\.pub//g' - | tr '\n' ',' | sed 's/,$//' -`
	if [[ `echo $keys | grep ","` -ne "" ]]; then
        	keys=`echo $keys | sed 's/^\(.*\)$/$HOME\/.ssh\/\{\1\}/' -`
	else
        	keys="$HOME/.ssh/$keys"
	fi
	ssh-add -q $keys &>/dev/null
}
