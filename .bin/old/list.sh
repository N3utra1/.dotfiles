cd ~/Documents/Scratch
rm -r $1
mkdir $1
cp ~/.bin/listConverter.py $1 
cd $1
vim list
python3 listConverter.py $1
pdflatex latex.tex
okular latex.pdf
