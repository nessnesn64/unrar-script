#!/bin/bash

echo "This is the current working directory"

echo $PWD

echo "Please enter the directory we will be working from"

read extract_directory

#Print entered subdirectory
echo $extract_directory

cd $extract_directory

echo "We are now working from within $PWD"

#Change the below to whereever you want the unrar'd files to be dropped off to

unrar_dropoff=/mnt/usb1/unrar

if [ -d $unrar_dropoff ]
then
    echo "unrar extract folder exists"
fi

if [ ! -d $unrar_dropoff ]
then
    mkdir $unrar_dropoff
    echo "unrar extract folder has been created"
fi


#Countdown timer before rest of script runs

echo "sleeping for 10 secs"

for t in {10..1};
do
    echo $t
    sleep 1
done




folders=( * )

echo ${folders[*]}

echo ${#folders[@]}

for n in ${folders[@]}
do
    echo $n
    cd $n
    echo "We are now working from within $PWD"
    rars=( *.rar )
    #echo ${#rars[@]}
    rarstart=${rars[0]}
    echo $rarstart
    unrar -x e $rarstart
    if [ -f *.avi ]
    then
        mv *.avi $unrar_dropoff
    fi
    if [ -f *.mp4 ]
    then
        mv *.mp4 $unrar_dropoff
    fi
    cd ..
    echo "We are now working from within $PWD"

done

echo $PWD
cd $extract_directory
ls
mkdir extraction
mv /mnt/usb1/unrar/*.* ./extraction
