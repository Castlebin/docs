#! /bin/bash

echo "---------moving---------"
for file in `find *.c`
do
        mv $file $1"/"$file
done
ls $1 -lS