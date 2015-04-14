#!/bin/bash
#shell_b.sh
d_name=""
f_name="" 
# mkdir dir1..dir10
for d_index in {1..10}
do
	d_name=dir$d_index
	mkdir -p $d_name
	# into derectory $d_name
	cd $d_name
	# create file dir1_file1..dir10_file10
	for f_index in {1..10}
	do
		f_name=${d_name}file$f_index
		#echo $f_name
		touch $f_name	
		chmod 755 $f_name
	done
	cd ..	#back to parent directory
done

echo please input an integer range from 1 to 10:
read index
if [ $index -ge 1 -a $index -le 10 ]
then
	slt_dir=dir$index
	cd $slt_dir	#mv into directory dir*
	for i in $(ls | grep -v ".*\..*")
	do
		echo $i
		mv $i $i.bak
		echo $i >> ../out.txt 
	done
	find .. -name "*$index*" | xargs rm -rf
fi
