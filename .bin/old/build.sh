#!/bin/sh
#deps=("lib/somelib.jar":"lib/someotherlib.jar")
if [ -z "$deps" ] 
then
    echo "no deps"
    javac -d "bin" @paths.txt #with no deps
else
    javac -d "bin" -cp lib/somelib.jar:lib/someotherlib.jar @paths.txt #with #deps
fi
#Also, if you get an error while compiling about an import in the main class from a subpackage
#try compiling by using the following command (assuming that the .java files are in a folder
#called src/ :
#javac -d "bin" @paths.txt -cp "src/"