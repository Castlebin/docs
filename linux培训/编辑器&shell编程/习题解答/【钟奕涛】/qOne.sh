#!/bin/bash

if [ -e "$1" ]
then
	echo "Move the files to file directory $1"
else
	mkdir $1
	if [ -e "$1" ]
	then
		echo "Create new file directoty: $1"
	fi
fi

mv *.c $1
ls ./$1 -lSr
