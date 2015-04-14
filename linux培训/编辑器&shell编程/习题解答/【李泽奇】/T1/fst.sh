#! /bin/sh
#for shell exercise title 1

if [ $# -lt 1 ]
then
    echo "you should put a parameter!\n"
    exit 1
fi

for file in *.c
do
    mv ${file} $1/$file
done

ls $1 -lS 

