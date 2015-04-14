#!/bin/bash
# program: 
#        move all the *.c files to the dictionary you select
#        you must input absolut path!
#

read -p "please input the dictionary where you want to move :" $dicname
mkdir $dicname
find ./ -name "*.c" -exec mv {} $dicname \;

ls -sl $dicname  