#!/bin/bash

# Script created by Ben Cordeiro

find_type () {

find /home -name "*.$TYPE" 2>/dev/null

}

#find /home -name "*.$TYPE" 2>/dev/null
YESNO=y
    read -p 'Search for files in home diretories? (Y/n)' var_yesno
    [ -n "$var_yesno" ] && YESNO=$var_yesno

if [ $YESNO = y ]; then

TYPE="mp3"
    find_type
TYPE="flv"
    find_type
TYPE="mov"
    find_type
TYPE="sh"
    find_type
TYPE="mp4"
    find_type
TYPE="avi"
    find_type
TYPE="mpg"
    find_type
TYPE="mpeg"
    find_type
TYPE="flac"
    find_type
TYPE="m4a"
    find_type
TYPE="ogg"
    find_type
TYPE="gif"
    find_type
TYPE="png"
    find_type
TYPE="jpg"
    find_type
TYPE="jpeg"
    find_type
TYPE="pptx"
    find_type
TYPE="pptx"
    find_type
TYPE="wav"
    find_type
TYPE="bat"
    find_type
TYPE="zip"
    find_type
TYPE="dat"
    find_type
TYPE="log"
    find_type
TYPE="xml"
    find_type
TYPE="pst"
    find_type
TYPE="py"
    find_type
TYPE="mkv"
    find_type
fi
echo
YESNO=y
    read -p 'Also look for .txt files? (Y/n)' var_yesno
    [ -n "$var_yesno" ] && YESNO=$var_yesno

if [ $YESNO = y ]; then

TYPE="txt"
    find_type

fi

echo 'Successfully Completed Search! I hope'
exit
