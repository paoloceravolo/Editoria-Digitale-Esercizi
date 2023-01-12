# Esercizi con Pandoc
<!-- https://learnbyexample.github.io/customizing-pandoc/ -->

MarkDown to PDF:

``
 pandoc sample_1.md -f gfm -o sample_1.pdf
``

Proviamo ora a inserire un blocco di pagina per ogni sezione, in modo da creare i capitoli
Dobbiamo per prima cosa creare un file header.tex 

	\usepackage{sectsty}
	\sectionfont{\clearpage}

``
pandoc sample_1.md -f gfm -H header.tex -o sample_1_chapter_break.pdf
``

-H FILE, --include-in-header=FILE|URL
Include contents of FILE, verbatim, at the end of the header. This can be used, for example, to include special CSS or JavaScript in HTML documents. This option can be used repeatedly to include multiple files in the header. They will be included in the order specified. 


Se il motere predefinito non può essere usato è possibile definre un nuovo motore

``
pandoc sample_1.md -f gfm -H header.tex --pdf-engine=lualatex -o sample_1_chapter_break.pdf
``

``
pandoc sample_1.md -f gfm -H header.tex --pdf-engine=xelatex -o sample_1_chapter_break2.pdf
``

In alternativa possiamo mettere tutte le opzioni in uno script 


	#!/bin/bash

	pandoc "$1" \
    -f gfm \
    --include-in-header header.tex \
    -V linkcolor:blue \
    -V geometry:a4paper \
    -V geometry:margin=2cm \
    -V mainfont="Palatino" \
    -V monofont="Palatino" \
    -V fontsize=12pt \
    --pdf-engine=xelatex \
    -o "$2"
    

  
  Per poi eseguire in questo modo
  
	
 	chmod +x md2pdf.sh
 	./md2pdf.sh sample_1.md sample_1_settings.pdf

Esistono diversi stili di colorazione della sintassi che si possono utilizzare


	pandoc --list-highlight-styles
	pygments 
	tango 
	espresso
	zenburn
	kate
	monochrome
	breezedark
	haddock

Quindi possiamo avere

	pandoc sample_1.md -f gfm -H header.tex --highlight-style kate --pdf-engine=xelatex -o sample_1_chapter_break2.pdf


Per la gestione delle liste possiamo usare opzioni come

	\usepackage{enumitem}
	\usepackage{amsfonts}
	
	% level one
	\setlist[itemize,1]{label=$\bullet$}
	% level two
	\setlist[itemize,2]{label=$\circ$}
	% level three
	\setlist[itemize,3]{label=$\star$}
	
	
Per generare un ePub preparaimo uno script che includa anche TOC e cover

	#!/bin/bash
	
	pandoc "$1" \
	-f gfm \
	--include-in-header header.tex \
	-V linkcolor:blue \
	-V geometry:a4paper \
	-V geometry:margin=2cm \
	-V mainfont="Palatino" \
	-V monofont="Palatino" \
	-V fontsize=12pt \
	--pdf-engine=xelatex \
	--highlight-style  espresso \
	--toc \
	--toc-depth 2 \
	--epub-cover-image cover.jpg \
	-o "$2"
	
Uno script più completo può essere il seguente 

	#!/bin/bash

	if [ $# -lt 1 ]
  	then
    	echo "No arguments supplied. Please provide the path to a markdown file"
   		exit 1
	fi

	input_file=$1
		output_file="${input_file%.*}.epub"

	# Default values for options
	epub_version="3.0"
	toc_level=2

	# Parse command-line options
	while [[ $# -gt 1 ]]
	do
	key="$1"

	case $key in
	    -e|--epub-version)
	    epub_version="$2"
	    shift # past argument
	    ;;
	    -t|--toc-level)
	    toc_level="$2"
	    shift # past argument
	    ;;
	    *)
	          # unknown option
	    ;;
	esac
	shift # past argument or value
	done

	pandoc $input_file -o $output_file --epub-version=$epub_version --toc --toc-depth=$toc_level --include-in-header header.tex --epub-metadata=metadata.xml --epub-cover-image=cover.jpg

	echo "EPUB file created successfully: $output_file"
	
Si può quindi invocare lo script in questo modo

	./script.sh myfile.md -e 2.0 -t 3