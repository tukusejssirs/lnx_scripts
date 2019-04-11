# This script eases scanning from terminal.

# Exit codes:
# 0 success
# 1 invalid scanning mode
# 2 invalid file format

# scanimage [grey|colour|lineart] [filename.ext]

# author:  Tukusej's Sirs
# date:    11 April 2019
# version: 1.2

# TODO:
# - retVal's are not working yet

#!/bin/bash
function scan(){
	local retVal=0
	# Device
	# if [[ $SANE_DEFAULT_DEVICE == "" ]]; then
		# SANE_DEFAULT_DEVICE=$(scanimage -f "%d")
	# fi
	# local device=$SANE_DEFAULT_DEVICE
	local device=$(scanimage -f "%d")

	# Options
	local opt="-p --resolution 600"
	# File name
	local filename="$2"

	# Mode
	case $1 in
		grey|gray|g|bw)
			# Grey
			local opt+=" --mode Gray"
			;;
		colour|color|c)
			# Colour
			local opt+=" --mode Color"
			;;
		lineart|l)
			# Lineart
			local opt+=" --mode Lineart"
			;;
		*)
			echo "ERROR: Scanning mode is invalid. Valid modes are grey, colour or lineart."
			local retVal=1
	esac

	# File format
	case $2 in
		*png)
			# png
			local format="png"
			;;
		*jpg|*jpeg)
			# jpg
			local format="jpeg"
			;;
		*tif|tiff)
			# tif
			local format="tiff"
			;;
		*pnm)
			# pnm
			local format="pnm"
			;;
		*)
			echo "ERROR: Unknown format. Valid formats are png, jpg, tif, pnm."
			local retVal=2
	esac

	# Actual command
	# if [[ $retVal > 0 ]]; then
		scanimage -d $device $opt --format=$format > "$filename"
	# else
	# 	return $retVal
	# fi

	unset retVal device opt filename format
}