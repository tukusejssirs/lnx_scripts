# This function round a floating number accourding to IEEE 754 – Rounding to nearest, ties away from zero

# $1 is precision
# $2 is floating number to round

#!/bin/bash
function round(){
	LC_ALL=C /usr/bin/printf "%.*f\n" $1 $2
}