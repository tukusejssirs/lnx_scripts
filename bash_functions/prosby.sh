#!/bin/bash

# progress aliases
function prosby(){
	fdefault="\e[39m"
	lred="\e[91m"
	lgreen="\e[92m"
	lyellow="\e[93m"
	lblue="\e[94m"
	lmagenta="\e[95m"
	smv_i=$(printf "%5s" `ls $HOME/git/prosby_ocr/txt/smv_i | wc -l`)
	smv_ii=$(printf "%6s" `ls $HOME/git/prosby_ocr/txt/smv_ii | wc -l`)
	chckd=$(printf "%5s" `ls $HOME/git/prosby_ocr/txt/chckd | wc -l`)
	todo=$(printf "%4s" $(expr $smv_i + $smv_ii - $chckd))
	total=$(printf "%4s" $(expr $smv_i + $smv_ii + $chckd))
	chckdPer=$(LC_ALL=C /usr/bin/printf "%05.2f\n" $(echo "$chckd * 100 / ($smv_i + $smv_ii)" | bc -l))
	todoPer=$(LC_ALL=C /usr/bin/printf "%05.2f\n" $(echo "$chckd * 100 / ($smv_i + $smv_ii)" | bc -l))
	echo -e "${lyellow}smv_i${fdefault}    ${lred}smv_ii${fdefault}      ${lgreen}chckd${fdefault}            ${lmagenta}todo${fdefault}            ${lblue}total${fdefault}"
	echo -e "${lyellow}$smv_i${fdefault}  + ${lred}$smv_ii${fdefault}  -${lgreen}$chckd ($chckdPer %)${fdefault}  = ${lmagenta}$todo ($todoPer %)${fdefault}  ${lblue}$total${fdefault}"
}