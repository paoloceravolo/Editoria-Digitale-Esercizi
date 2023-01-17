#!/bin/bash

input=$1
output=$2

pandoc $input -o $output \
--css=epub.css \
--epub-cover-image=cover.jpg \
--epub-metadata=metadata.xml \
--epub-embed-font='./fonts/dejavu-serif/DejaVuSerif.ttf' \
-t epub3 --mathml