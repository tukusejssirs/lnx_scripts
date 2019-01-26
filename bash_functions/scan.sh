# This script eases scanning from terminal.

# scanimage [grey|colour|lineart] [filename.ext]

# author:  Tukusej's Sirs
# date:    26 Jan 2019
# version: 1.0

#!/bin/bash
function scan(){
	# Device
	if(SANE_DEFAULT_DEVICE != ""); then
		device=$SANE_DEFAULT_DEVICE
	else
		SANE_DEFAULT_DEVICE=$(scanimage -f "%d")
		device=$SANE_DEFAULT_DEVICE
	fi

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
	esac

	# Actual command
	scanimage -d $device $opt --format=$format > "$filename"
}