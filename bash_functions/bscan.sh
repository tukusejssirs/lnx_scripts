# Device
if [[ $SANE_DEFAULT_DEVICE == "" ]]; then
	SANE_DEFAULT_DEVICE=$(scanimage -f "%d")
fi
device=$SANE_DEFAULT_DEVICE

filename=$(echo "$1" | grep -Po "^.*(?=\.[a-zA-Z]*$)")
start=$2
end=$3
digits=$4
format=$(echo "$1" | grep -Po "\.\K[a-zA-z]*$")



# Option to re-scan [R]
# Option to scan next [Enter]

for n in $(seq $start $end); do
	num=$(printf "%0*d\n" $digits $n)

	while [ "$ans" != "N" ] && [ "$ans" != "n" ]; do
		while [ "$ans" != "N" ] && [ "$ans" != "n" ]; do
			# scanimage -d $device -p --resolution 600 --mode Color --format=png --batch-start > $num_$filename.$format
			echo $num_$filename.$format
			read ans
			case $ans in
				N|n)  # Next scan
					echo -n
				;;
				*)  # Read $ans again
					echo -n
				;;
			esac
		done
	done
done