#!/bin/bash
#
#
#
read -p "input num:" num
echo $num | awk '{if(NF < 3) {printf "please input more than 3 numbers\n"}
else{sum = 0 ; min = $i; max = $i; i = 1;
while(i <= NF)
{
	sum = sum + $i; 
	if(min > $i)
	{
		min = $i;
	} 
	else(max < $i)
	{
		max = $i;
	}
	i = i + 1;
}
 printf " maxNum is %d, minNum is %d, average is %f\n",max,min,sum/NF;
}}'
exit 0