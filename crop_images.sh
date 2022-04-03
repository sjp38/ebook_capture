#!/bin/bash

if [ $# -ne 5 ]
then
	echo "Usage: $0 <dir> <left> <top> <right> <bottom>"
	exit 1
fi

bindir=$(dirname "$0")
dir=$1
left=$2
top=$3
right=$4
bottom=$5

for image in "$dir"/*
do
	echo "crop $image"
	"$bindir/_crop.sh" "$image" "$left" "$top" "$right" "$bottom"
done
