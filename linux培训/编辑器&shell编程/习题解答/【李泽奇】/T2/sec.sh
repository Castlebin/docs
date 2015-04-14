#! /bin/sh
#for shell exercise title 2

#create directories and files
for k in $(seq 1 10)
do
    mkdir dir${k}
    cd dir${k}
    for l in $(seq 1 10)
    do
        touch dir${k}file${l}
        chmod 755 dir${k}file${l}
    done
    cd ..
done

#waiting for enter
echo -n "Please select a directory(1-10):"
read directNum

#input check
while [ $directNum -lt 1 ] || [ $directNum -gt 10 ]
do
    echo -n "The input number should be 1-10,please input again:"
    read directNum
done

#rename all .c files to .bak in the specified directory
cd dir${directNum}
rename 's/$/.bak/' ./*
#save all files' names to file in the specified directory  
ls >../out
#delete dirs and files whose name include the enter number
rm -rf ../*${directNum}*

