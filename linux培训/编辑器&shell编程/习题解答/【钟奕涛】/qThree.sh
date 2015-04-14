#!/bin/bash

echo "input argments number:$#"

if [ $# -lt 3 ]
then
echo "The count of input number is less than 3!"
exit
fi

echo "what you input is:"
for arg in "$*"
do
	echo "$arg"
done

max=$1
min=$1
sum=0
for i in $*
do
	if [ "$i" -gt "$max" ]
	then
		max=$i
	elif [ "$i" -lt "$min" ]
	then
		min=$i
	fi
	
	let "sum+=$i"
done

#echo "sum:$sum"

average=`echo "scale=2;$sum/$#" |bc`

echo "max number is:$max"
echo "min number is:$min"
echo "average is:$average"

