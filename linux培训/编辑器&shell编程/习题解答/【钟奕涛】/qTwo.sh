#!/bin/bash

for dirNum in {1..10}
do
	dirName="dir$dirNum"
	echo $dirName
	if [ -e "$dirName"  ]
	then
		rm -rf $dirName
	fi	
	mkdir $dirName
	cd $dirName
	for fileNum in {1..10}
		do
			fileName=""$dirName"_file"$fileNum""
			touch $fileName
			#chmod 755 $fileName
			chmod u=rwx $fileName
			chmod g=rx $fileName
			chmod o=rx $fileName
		done
	ls -l
	cd ..	
done

if [ ! -e out ]
then
	touch out
fi

echo "Please input a number between 1 to 10: "
read num

while [ $num -lt 1 -o  $num -gt 10 ]
do
	echo "Wrong num,please input a number between 1 to 10:"
	read num
done

cd "dir$num"
find . -name "dir*" |while read i
do
	mv $i $i.bak
	bakName=$(basename $i)
	echo "$bakName.bak" >> ../out
done

echo "Rename file name successfully!"
ls
 
cd ..

tail -10 out

rm -rf *$num*

echo "remove file or drectory contain $num successfully!"
ls
 
