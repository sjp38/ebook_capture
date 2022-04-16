#!/bin/bash

if [ $# -ne 3 ]
then
	echo "Usage: $0 <output directory> <start page> <end page>"
	exit 1
fi

out_dir=$1
start_page=$2
end_page=$3

mkdir -p "$out_dir"
for ((i = $start_page; i <= $end_page; i++))
do
	page=$(printf "%05d\n" $i)
	percent=$(((i - start_page) * 100 / (end_page - start_page + 1)))
	echo "capturing $page page ($percent % done)"
	adb exec-out screencap -p > "$out_dir/$page.png"
	adb shell input tap 1000 2000
	sleep 1
done
