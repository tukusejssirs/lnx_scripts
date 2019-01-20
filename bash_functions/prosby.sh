#!/bin/bash

# progress of prosby_ocr
function prosby(){
fdefault="\e[39m"
lred="\e[91m"
lgreen="\e[92m"
lyellow="\e[93m"
lblue="\e[94m"
lmagenta="\e[95m"
smv_i=$(printf "%3s" `ls $HOME/git/prosby_ocr/txt/smv_i | wc -l`)
smv_ii=$(printf "%3s" `ls $HOME/git/prosby_ocr/txt/smv_ii | wc -l`)
chckd=$(printf "%3s" `ls $HOME/git/prosby_ocr/txt/chckd | wc -l`)
todo=$(printf "%3s" $(expr $smv_i + $smv_ii))
total=$(printf "%3s" $(expr $todo + $chckd))
smv_iPer=$(LC_ALL=C /usr/bin/printf "%04.1f\n" $(echo "$smv_i * 100 / $total" | bc -l))
smv_iiPer=$(LC_ALL=C /usr/bin/printf "%04.1f\n" $(echo "$smv_ii * 100 / $total" | bc -l))
chckdPer=$(LC_ALL=C /usr/bin/printf "%04.1f\n" $(echo "$chckd * 100 / $total" | bc -l))
todoPer=$(LC_ALL=C /usr/bin/printf "%04.1f\n" $(echo "$todo * 100 / $total" | bc -l))

echo -e "${lyellow}smv_i${fdefault}         ${lred}smv_ii${fdefault}        ${lgreen}chckd${fdefault}          ${lmagenta}todo${fdefault}           ${lblue}total${fdefault}"
echo -e "${lyellow}$smv_i ($smv_iPer %)${fdefault}, ${lred}$smv_ii ($smv_iiPer %)${fdefault}, ${lgreen}$chckd ($chckdPer %)${fdefault} + ${lmagenta}$todo ($todoPer %)${fdefault} = ${lblue}$total${fdefault}"
}