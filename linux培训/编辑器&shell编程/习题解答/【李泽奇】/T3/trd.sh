#! /bin/bash
# for shell title 3

#param numbers check
if [ $# -lt 3 ]
then
    echo "The number of parameter should not be less than 3!"
    exit 1

else
    max=$1
    min=$1
    sum=0
    for k in $@
    do
        #float param check
        if [ $(echo "$k / 1"|bc) != $k ] || [ $k -lt 0 ]
        then
	    echo "Invalid param,param should be a integer and not less than 0"
            exit 1
        fi 
        #sum for average
        let "sum+=$k"
        #max
        if [ $k -gt $max ]
        then 
            let "max=$k"
        fi
        #min
        if [ $k -lt $min ]
        then
            let "min=$k"
        fi
    done
    echo -n "max number is:"
    echo $max
    echo -n "min number is:"
    echo $min
    echo -n "average is:"
    average=$(echo "scale=2;$sum / $#"|bc)
    echo $average

fi 
