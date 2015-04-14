#!/bin/bash

if [ "$#" -lt 3 ]
then 
	echo "error!please input at least 3 number!"
	exit 1
fi

sum=0
max=0
min=0
count=0

for num in "$@"
do
expr $num + 1 >/dev/null 2>&1
if [ ! $? -eq 0 ]
then
	echo "error!please input integers!"
        exit 1
fi
sum=`echo "scale=2;$sum + $num" | bc`
let  count+=1
if [ "$num" -gt "$max" ]
then
	max=$num
fi
if [ "$min" -eq 0 ]
then
	min=$num
elif [ "$num" -lt "$min" ]
then
	min=$num
fi
done

echo "max number is $max"
echo "min number is $min"
average=`echo "scale=2;$sum / $count" |bc`
echo "average is $average"

