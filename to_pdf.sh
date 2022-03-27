#!/bin/bash

if [ $# -ne 1 ]
then
	echo "Usage: $0 <images dir>"
	exit 1
fi

images_dir=$1
output_name=$(basename "$images_dir")
output_pdf="$output_name.pdf"
orig_output_pdf="$output_name-orig.pdf"

if [ -f "$output_pdf" ]
then
	echo "$output_pdf already exist"
	exit 1
fi

if [ -f "$orig_output_pdf" ]
then
	echo "$orig_output_pdf already exist"
	exit 1
fi

echo "trim"
mogrify -trim "$images_dir"/*
echo "compress images"
pngquant "$images_dir"/*

echo "remove uncompressed images"
for file in "$images_dir"/*fs8.png
do
	name=$(echo "$file" | awk -F'-fs8' '{print $1}')
	mv "$file" "$name.png"
done

echo "make one pdf"
convert "$images_dir"/*.png +repage "$orig_output_pdf"
echo "reduce size for ebook"
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook \
	-dNOPAUSE -dQUIET -dBATCH -sOutputFile="$output_pdf" "$orig_output_pdf"
