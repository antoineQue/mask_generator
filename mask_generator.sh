#!/bin/bash


minuscule="abcdefghijklmnopqrstuvwxyz"
majuscule="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
dec="0123456789"
special="!\"#$%&'()*+,-./:;<=>?@[\]^_\`\{\|\}~"

rm generated_mask.hcmask

while read pass
do

	lenght=${#pass}
	mask=""

	for position in $(seq 1 $lenght)
	do

		letter=$(echo $pass | cut -c$position)
		if [[ $minuscule == *"$letter"* ]]
		then
			mask+="?u"
		elif [[ "$majuscule" == *"$letter"* ]]
		then
			mask+="?l"
		elif [[ "$dec" == *"$letter"* ]]
		then
			mask+="?d"		

		elif [[ "$special" == *"$letter"* ]]
		then
			mask+="?s"
		fi

	done

	echo $mask >> tmpmask




done < $1

cat tmpmask | sort | uniq | awk '{ print length, $0 }' | sort -n -s | cut -d" " -f2- | tee -a generated_mask.hcmask
rm tmpmask