#!/bin/bash

declare -i sum=0
declare -i max=0
declare -i min=0

if (( $# != 3 ))
then 
	echo please input 3 param
	exit 1
fi

if [[ "$1" =~ ^[0-9]+$ ]] 
then
	let "max=$1"
	let "min=$1"
	let "sum=$1"
else
	echo $1 is not a number
	exit 1
fi

if [[ "$2" =~ ^[0-9]+$ ]]
then
	let "sum+=$2"
	if (( $2 > $max ))
	then 
		let "max=$2"
	fi

	if (( $2 < $min ))
	then 
		let "min=$2"
	fi
else
	echo $2 is not a number
	exit 1
fi

if [[ "$3" =~ ^[0-9]+$ ]]
then
	let "sum+=$3"
	if [[ $3 > $max ]]
	then
		let "max=$3"
	fi

	if [[ $3 < $min ]]
	then
		let "min=$3"
	fi
else
	echo $3 is not a number
fi

echo max number is:$max
echo imin number is:$min
echo -n  average is:
echo "scale=2;$sum/3"|bc
