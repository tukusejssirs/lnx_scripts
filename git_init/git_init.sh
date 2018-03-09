#!/bin/bash

user_name = ""
user_email = ""
# Check if `git` and `ssh` are installed; if they are not, install them
if [[ ! -e /usr/bin/git && ! -e /usr/bin/ssh ]]; then
	sudo apt-get -yq update && sudo apt-get -yq install git ssh
elif [[ ! -e /usr/bin/git ]]; then
	sudo apt-get -yq update && sudo apt-get -yq install git
elif [[ ! -e /usr/bin/ssh ]]; then
	sudo apt-get -yq update && sudo apt-get -yq install ssh
fi

# Git configuration
git config --global user.name $user_name
git config --global user.email $user_email
git config --global push.default simple

# ssh key generation
ssh-keygen -t ed25519 -a 100 -f ~/.ssh/$USER@$HOSTNAME -P ""

# chmod ~/.ssh/*
chmod 700 ~/.ssh/*

# echo just generated public key
cat ~/.ssh/$USER@$HOSTNAME.pub

# Add key to the ssh-agent
eval `ssh-agent -s`
ssh-add ~/.ssh/$USER@$HOSTNAME
