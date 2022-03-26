#!/bin/bash

if [ $# -ne 2 ]
then
	echo "Usage: $0 <images dir> <output pdf file>"
	exit 1
fi

images_dir=$1
output_pdf=$2

echo "trim"
mogrify -trim "$images_dir"/*
echo "compress images"
pngquant "$images_dir"/*
echo "make one pdf"
convert "$images_dir"/*fs8.png +repage "orig-$output_pdf"
echo "reduce size for ebook"
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook \
	-dNOPAUSE -dQUIET -dBATCH -sOutputFile="$output_pdf" "orig-$output_pdf"
