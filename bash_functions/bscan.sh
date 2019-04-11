# This function create a batch scanning from function in `scan.sh` script

# Usage: $0 [filename].[extension] [colour_mode] [start_number] [end_number] [number_of_digits_in_number]
# Press N or n to scan next page
# Press R or r to re-scan current page

# author:  Tukusej's Sirs
# date:    11 April 2019
# version: 1.0

function bscan(){
	filename=$(echo "$1" | grep -Po "^.*(?=\.[a-zA-Z]*$)")
	colour_mode=$2
	start=$3
	end=$4
	digits=$5
	format=$(echo "$1" | grep -Po "\.\K[a-zA-z]*$")
	lnx_scripts="$PWD/git/lnx_scripts"
	source $lnx_scripts/bash_functions/scan.sh

	for n in $(seq $start $end); do
		num=$(printf "%0*d\n" $digits $n)
		ans="r"
		while [ "$ans" = "R" ] || [ "$ans" = "r" ]; do
			# scanimage [grey|colour|lineart] [filename.ext]
			scan $colour_mode $num_$filename.$format
			# scanimage -d $device -p --resolution 600 --mode Color --format=png --batch-start > $num_$filename.$format
			while read ans && [ "$ans" != "R" ] && [ "$ans" != "r" ] && [ "$ans" != "N" ] && [ "$ans" != "n" ]; do
				echo -n
			done
		done
	done
}