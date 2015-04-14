#!/bin/bash
# program
#
#
N=1
for ((i = 0; i <10; i=i+1))
do
		mkdir ./dir"$N"
		M = 1
		for((j = 0; j <10; j=j+1))
		do
			touch ./dir"$N"/dir"$N"file"$M"
			chmod 755 ./dir"$N"/dir"$N"file"$N"
			M=$(($M+1))
		done
		N=$(($N + 1))
done

read -p "input the num of file you want to chang name:" num

find ./dir"$num" -name "dir"$num"file*" -exec mv {} {}num \; 
ls ./dir"$num" >> out.txt
exit 0
 

