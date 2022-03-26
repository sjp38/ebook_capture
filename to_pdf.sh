#!/bin/bash

if [ $# -ne 2 ]
then
	echo "Usage: $0 <images dir> <output pdf file>"
	exit 1
fi

images_dir=$1
output_pdf=$2

mogrify -trim "$images_dir"/*
pngquant "$images_dir"/*
convert "$images_dir"/*fs8.png +repage "orig-$output_pdf"
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook \
	-dNOPAUSE -dQUIET -dBATCH -sOutputFile="$output_pdf" "orig-$output_pdf"