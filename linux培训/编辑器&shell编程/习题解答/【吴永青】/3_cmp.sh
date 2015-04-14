#!/bin/bash
if [ $# -lt 3 ]
then
	echo "please input more than three parms!"
	exit
fi

max=$1
min=$1
sum=0

for arg in "$@"
do
	((sum=$sum+$arg))
	if [ $max -lt $arg ]
	then
		max=$arg
	fi
	if [ $min -gt $arg ]
	then
		min=$arg
	fi
done

avg=` echo "scale=2;$sum/$#" | bc `

echo "max number is:$max"
echo "min number is:$min"
echo "average is :$avg"
