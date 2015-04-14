#!/bin/bash

mkdir dir{1..10}
for ((i=1;i<=10;i++))
do
	touch dir$i/dir"$i"file{1..10}
	chmod 0755 dir$i/dir"$i"file{1..10}
done

echo -n "please input a number(1-10):"
read number

if [ $number -le 10 -a $number -ge 1 ]
then
	for ((i=1;i<=10;i++))
	do
		mv dir$number/dir"$number"file"$i" dir$number/dir"$number"file"$i".bak
	done
	cd dir$number
	ls > ../out
	cd ..
	rm -r dir$number
	for ((i=1;i<=10;i++))
	do
		if [ $i -ne $number ]
		then
			rm dir$i/dir"$i"file$number
		fi
	done
else
	echo "input error!"
fi
