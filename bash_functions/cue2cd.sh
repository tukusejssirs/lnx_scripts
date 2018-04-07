#!/bin/bash

# This function is a helper in virtualising CD bin/cue images.
# WARNING: This function if under development and not work as intended.

# dependencies: if then cdemu grep while sed echo

# function cue2cd(){
	# Options
	#   mount: cdemu load 0 [name].cue
	#   umount: cdemu unload 0
	#   list-mounted: cdemu device-mapping
	#   umount-all: cdemu unload all
	#   show-path: echo /run/user/1000/gvfs/cdda\:host\=sr0
	#          or: echo /run/user/*/gvfs/cdda\:host\=sr*

	# Short help
	#
	# $0 [mount|umount|list-mounted|umount-all|show-path] [file]
	# 
	# Options:
	#   mount
	#   umount
	#   list-mounted
	#   umount-all
	#   show-path
	#   [file]  a .cue file

	# Set variables from command-line arguments
	export option=$1
	if [[ "$3" ]]; then
		device=$2
		file=$3
	else
		file=$2
	fi

	if [[ "$option" == "mount" ]]; then
		# TODO: check if device `0` is exists; if yes, check if is already loaded; if not, mount
		# Check if device 0 exists
		avail_devs=`cdemu status | grep -o ^[0-9]*`
		if [[ `echo $avail_devs | grep -o $devices` == $devices ]]; then
			# Check if device is already loaded
			if [[ ! $device ]]; then
				while [[ $dev_status == "True" ]]; do
				/media/janka/35D2-1FB2/kelemen_gabor	device = $(( $device + 1 ))
					dev_status=`cdemu status | grep -o "^$device[ ]*[TrueFals]*" | grep -o '[TrueFals]*'`
				done
			fi

			if [[ $dev_status -ne "True" ]]; then
				cdemu load $device "$2"
			else  # Presuming there are no devices available, than the last loaded/used
				cdemu add-device
				device=$(( $device + 1 ))
				cdemu load $device $file
			fi
		fi
	fi

	if [[ "$option" == "umount" ]]; then
		if [[ $device != "" ]]; then
			cdemu load unload $device
		else
			option="umount-all"
		fi
	fi

	if [[ "$option" == "umount-all" ]]; then
		cdemu load unload all
	fi

	if [[ "$option" == "show-path" ]]; then
		echo /run/user/*/gvfs/cdda\:host\=sr* | sed 's/\(sr[0-9]+\)[ \t]*/\1\n/g' -
	fi

	if [[ "$option" == "list-mounted" ]]; then
		cdemu status
	fi
# }