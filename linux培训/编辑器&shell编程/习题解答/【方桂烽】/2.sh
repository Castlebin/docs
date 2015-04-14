#! /bin/bash

for i in $(seq 10)
do
        mkdir dir$i
        cd dir$i
        for j in $(seq 10)
        do
                touch dir${i}file$j
                chmod 755 dir${i}file$j
        done
        cd ..
done

echo "input a number between 1 to 10:"
read num
while [ $num -lt 1 ] || [ $num -gt 10 ]
do
echo "input a number between 1 to 10:"
read num
done

cd dir$num
for i in $(ls)
do
        mv $i ${i}.cfg
done
ls >> ../out
cd ..
for i in $(seq 10)
do
        cd dir$i
        rm -f dir${i}file$num
        cd ..
done
rm -rf dir$num

