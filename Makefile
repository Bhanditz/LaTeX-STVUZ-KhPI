LATEX := xelatex
MAINFILE := $(shell f=`echo *.pdf`; if [ -r "$$f" ]; then echo $${f%%.pdf}; else basename $(PWD); fi)
SECTIONS := $(shell find sections -name '*.tex' )
am__tar = tar chof - "$$tardir"
clean_runtime := $(RM) *.aux *.log *.out *.toc *.bbl *.blg


all: mainpdf


mainpdf: $(MAINFILE).pdf


clean: clean-bak clean-runtime


clean-bak:
	$(RM) $(shell find . -name '*~')

clean-runtime:
	$(clean_runtime)

%.pdf: %.tex $(SECTIONS)
	$(clean_runtime)
	$(LATEX) $*.tex && bibtex $*.aux && $(LATEX) $*.tex && $(LATEX) $*.tex


dist: dist-gzip


dist-gzip:: mainpdf clean
	tardir="$(shell basename $(PWD))" && cd .. && $(am__tar) | gzip -c > $(MAINFILE).tar.gz


PHONY: all clean clean-bak clean-runtime mainpdf dist dist-gzip
