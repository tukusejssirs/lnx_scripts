# This function create a batch scanning from function in `scan.sh` script

# Usage: $0 [filename].[extension] [colour_mode] [start_number] [end_number] [number_of_digits_in_number]
# Press N or n to scan next page
# Press R or r to re-scan current page

# author:  Tukusej's Sirs
# date:    11 April 2019
# version: 1.1

function bscan(){
	local filename=$(echo "$1" | grep -Po "^.*(?=\.[a-zA-Z]*$)")
	local colour_mode=$2
	local start=$3
	local end=$4
	local digits=$5
	local format=$(echo "$1" | grep -Po "\.\K[a-zA-z]*$")
	local lnx_scripts="$HOME/git/lnx_scripts"
	source $lnx_scripts/bash_functions/scan.sh

	for n in $(seq $start $end); do
		local num=$(printf "%0*d\n" $digits $n)
		local ans="r"
		local temp_name="$num"_"$filename.$format"
		while [ "$ans" = "R" ] || [ "$ans" = "r" ]; do
			# scanimage [grey|colour|lineart] [filename.ext]
			scan $colour_mode "$temp_name"
			# scanimage -d $device -p --resolution 600 --mode Color --format=png --batch-start > $num_$filename.$format
			while read ans && [ "$ans" != "R" ] && [ "$ans" != "r" ] && [ "$ans" != "N" ] && [ "$ans" != "n" ]; do
				echo -n
			done
		done
	done
	unset filename colour_mode start end digits format lnx_scripts ans num ans temp_name
}