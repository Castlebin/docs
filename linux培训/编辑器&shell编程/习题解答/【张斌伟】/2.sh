#!/bin/bash


for((i=1; i<11; i++))
do 
	mkdir dir$i
	cd dir$i
	for((j=1;j<11; j++))
	do
		touch file$j
	done
	cd ..
	chmod -R u=wrx,g=rw,o=rx dir$i

	echo dir$i
done

echo "please input an integer(1-10)"
read inputInt

if [ $inputInt -lt 1 -o  $inputInt -gt 10 ] 
then 
	echo "shit"
fi

cd dir$inputInt

for((i=1;i<11;i++))
do
	mv -f file$i file$i.bak
done

cd ..

cp -rf dir$inputInt out


rm -rf *[0-9]*
