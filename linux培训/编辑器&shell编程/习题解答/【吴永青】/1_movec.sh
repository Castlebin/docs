#!/bin/bash

if [ $# != 0 ]
then
	if [ -d $1 ]
	then
		mv *.c $1
		cd $1
		ls -S
	else
		mkdir $1
		mv *.c $1
		cd $1
		ls -S
	fi
fi
