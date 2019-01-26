# This script eases scanning from terminal.

# scanimage [grey|colour|lineart] [filename.ext]

#!/bin/bash
function scan(){
	device=$(scanimage -f "%d")
	opt="-p --resolution 600"
	filename="$2"

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

	scanimage -d $device $opt --format=$format > "$filename"
}