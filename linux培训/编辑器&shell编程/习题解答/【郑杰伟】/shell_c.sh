#!/bin/bash
#shell_c.sh
if [ $# -lt 3 ]
then
	echo "please input 3 parameters at least!"
	exit 1
fi
#echo $#
max=$1
min=$1
avg=0
sum=0
arg=0
for arg in $@
do
	#echo $arg
	if [ $max -lt $arg ]
	then	
		max=$arg
	fi

	if [ $min -gt $arg ]
	then
		min=$arg
	fi
	let "sum+=$arg"
done
#echo $sum
avg=`echo "scale=2;$sum / $#" | bc`
echo "max number is:$max"
echo "min number is:$min"
echo "average is:$avg"	
