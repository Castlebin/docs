#!/bin/bash
#shell_a.sh
words="input a new line!"
mkdir -p sortD

for i in {1..5}
do
	j=$i
	while(( $j > 0 ))
	do
		echo $words >> file$i.c
		let "j--"
	done
	mv file$i.c sortD
done

ls -Sl sortD 
