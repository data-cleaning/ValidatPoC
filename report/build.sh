#!/bin/bash

pdflatex vtl-proof-of-concept.tex
bibtex vtl-proof-of-concept
pdflatex vtl-proof-of-concept.tex
pdflatex vtl-proof-of-concept.tex


