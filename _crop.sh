#!/bin/bash

if [ $# -ne 5 ]
then
	echo "Usage: $0 <image> <left> <top> <right> <bottom>"
	echo "   Crop <left> <top> <right> <bottom> pixel of <image>"
	exit 1
fi

image=$1
left=$2
top=$3
right=$4
bottom=$5

resol=$(identify "$image" | awk '{print $3}')
width=$(echo "$resol" | awk -F'x' '{print $1}')
height=$(echo "$resol" | awk -F'x' '{print $2}')

new_width=$((width - left - right))
new_height=$((height - top - bottom))
crop_arg="$new_width"x"$new_height"+"$left"+"$top"

convert "$image" -crop "$crop_arg" "$image"
