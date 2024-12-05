import os
import sys
#make new latex file from template
#for each line, add "\item" at the beginning and insert in file at certain line

prefix1 = r"""\documentclass{article} 
\usepackage{geometry} % to change the page dimensions
\usepackage{graphicx} % support the \includegraphics command and options
\usepackage{float}
\geometry{a4paper}
\title{ """ 
prefix2 = sys.argv[1]
prefix3 = r"""}
\date{}
\begin{document}
\maketitle
\begin{itemize}"""
flines = ""
suffix = """\end{itemize}
\end{document}"""

if os.path.exists("latex.tex"):
    os.remove("latex.tex")
infile = open("list", "r")
outfile = open("latex.tex", "w")
lines = infile.readlines()
for line in lines:
    line = "\item " + line
    flines = flines + line
outfile.write(prefix1+prefix2+prefix3+"\n"+flines+suffix)
infile.close()
outfile.close()
