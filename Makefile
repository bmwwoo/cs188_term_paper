ABCs.pdf: cs188_final.tex
	pdflatex -jobname ABCs cs188_final.tex
	bibtex ABCs
	pdflatex -jobname ABCs cs188_final.tex
