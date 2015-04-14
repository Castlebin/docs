#!/bin/bash
#move all C file in cur dir to the dest dir,and list the dir by the size of file
echo "*******file mv***********"
echo "please input the dest dir"
read dir
if [ ! -d "$dir" ]
then
	echo "the dir is not exist!"
	exit 1
fi
mv *.c "$dir"
cd "$dir"
#sort by size
ls -l|sort -k5n
