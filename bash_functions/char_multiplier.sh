function char_multiplier(){  # src: https://stackoverflow.com/a/5799353/3408342
	str=$1
	num=$2
	v=$(printf "%-${num}s" "$str")
	echo "${v// /*}"
}