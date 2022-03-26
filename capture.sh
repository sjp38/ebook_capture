#!/bin/bash

if [ $# -ne 3 ]
then
	echo "Usage: $0 <start page> <end page> <output directory>"
	exit 1
fi

start_page=$1
end_page=$2
out_dir=$3

mkdir -p "$out_dir"
for ((i = $start_page; i <= $end_page; i++))
do
	page=$(printf "%05d\n" $i)
	percent=$((i * 100 / (end_page - start_page + 1)))
	echo "capturing $page page ($percent % done)"
	adb exec-out screencap -p > "$out_dir/$page.png"
	adb shell input tap 1000 2000
	sleep 1
done
