# This script eases scanning from terminal.

# Exit codes:
# 0 success
# 1 invalid scanning mode
# 2 invalid file format

# scanimage [grey|colour|lineart] [filename.ext]

# author:  Tukusej's Sirs
# date:    26 Jan 2019
# version: 1.0

# TODO:
# - retVal's are not working yet

#!/bin/bash
function scan(){
	retVal=0
	# Device
	if [[ $SANE_DEFAULT_DEVICE == "" ]]; then
		SANE_DEFAULT_DEVICE=$(scanimage -f "%d")
	fi

	device=$SANE_DEFAULT_DEVICE

	# Options
	opt="-p --resolution 600"
	# File name
	filename="$2"

	# Mode
	case $1 in
		grey|gray|g|bw)
			# Grey
			opt+=" --mode Gray"
			;;
		colour|color|c)
			# Colour
			opt+=" --mode Color"
			;;
		lineart|l)
			# Lineart
			opt+=" --mode Lineart"
			;;
		*)
			echo "ERROR: Scanning mode is invalid. Valid modes are grey, colour or lineart."
			retVal=1
	esac

	# File format
	case $2 in
		*png)
			# png
			format="png"
			;;
		*jpg)
			# jpg
			format="jpg"
			;;
		*tif)
			# tif
			format="tif"
			;;
		*pnm)
			# pnm
			format="pnm"
			;;
		*)
			echo "ERROR: Unknown format. Valid formats are png, jpg, tif, pnm."
			retVal=2
	esac

	# Actual command
	# if [[ $retVal > 0 ]]; then
		scanimage -d $device $opt --format=$format > "$filename"
	# else
	# 	return $retVal
	# fi
}