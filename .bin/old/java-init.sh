#!/bin/sh
mkdir src bin
cp ~/.bin/build.sh . 
cp ~/.bin/run.sh .
touch paths.txt
find -name "*.java" > paths.txt
chmod +x build.sh
chmod +x run.sh
echo "Please fill out the run.sh and the dependencies list in build.sh"