#!/bin/bash
for i in {1..10}
do
dir='dir'$i
if [ -d "$dir" ]
then
	rm -rf $dir
fi
	mkdir $dir
	cd $dir
        for j in {1..10}
        do
	  touch $dir'file'$j
	  chmod 755 $dir'file'$j
        done
        cd ..
done

echo "please input a integer,range from 1~10"
read num

expr $num + 1 >/dev/null 2>&1
if [ ! $? -eq 0 ]
then
	echo "param error!please input a integer!"
	exit 1
fi
echo "$num"
if [ "$num" -lt 1 -o "$num" -gt 10 ]
then
	echo "param error!please input a integer range from 1-10!"
	exit 1
fi

dir='dir'$num
cd $dir
for file in $( ls )
do
    mv "$file" $file'.bak'
done

if [ -e ../out ]
then
	rm ../out
fi

for file in $( ls )
do
    echo "$file" >> ../out
done

for file in $( find ../ -name "*$num*" )
do
    if [ -e $file ]
    then
#	echo "$file"
    	rm -rf $file
    fi
done
