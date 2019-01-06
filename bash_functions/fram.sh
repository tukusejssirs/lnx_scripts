# This script clears RAM
# You can use any option program `free` uses in order to change its output.

# author: Tukusej's Sirs (found on the Internet on multiple places)
# created: 24 Feb 2018
# dependencies; free sync sudo su echo
# version: 1.0

#!/bin/bash
function fram(){
	free -h $1; sync && sudo su -c "echo 2 > /proc/sys/vm/drop_caches" && echo && free -h $1
}