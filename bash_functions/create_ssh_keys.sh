# create_ssh_key [name]
#!/bin/bash
function create_ssh_key(){
	name=$1
	# Generating key
	ssh-keygen -t ed25519 -a 100 -f ~/.ssh/$name -P ""
	# Change permissions to 600
	chmod 600 ~/.ssh/$name*
	# Add key to ssh
	ssh-add ~/.ssh/$name
}
