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