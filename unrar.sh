#!/bin/bash

echo "This is the current working directory"

echo $PWD


echo "Are you extracting a Season (s) or collection of Episodes (e)?"

read type_selection

if [ $type_selection == "s" ]
then
    echo "Please enter the directory we will be working from"

    read extract_directory

    cd $extract_directory

    echo "We are now working from within $PWD"
fi

if [ $type_selection == "e" ]
then
    echo "Please enter the prefix of all episodes to extract"

    read directory_prefix

    cd /mnt/usb1/downloads

    echo "We are now working from within $PWD"
fi


#Print entered subdirectory
echo $extract_directory

echo $directory_prefix

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


if [ $type_selection == "s" ]
then
    folders=( * )
fi

if [ $type_selection == "e" ]
then
    folders=( $directory_prefix* )
fi

echo ${folders[*]}

echo ${#folders[@]}


#Countdown timer before rest of script runs
echo "sleeping for 10 secs"

for t in {10..1};
do
    echo $t
    sleep 1
done




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

    if [ -f *.mkv ]
    then
        mv *.mkv $unrar_dropoff
    fi
    cd ..
    echo "We are now working from within $PWD"

done


if [ $type_selection == "s" ]
then
    echo $PWD
    cd $extract_directory
    ls
    mkdir extraction
    mv /mnt/usb1/unrar/*.* ./extraction
fi

