#!/bin/bash

if [ ! -d $1 ] ; then 
echo "please input dest folder"
exit 1
fi

cp *.c $1

