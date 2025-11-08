#!/bin/bash

set -x

if [ $# -lt 2 ]
  then
  echo "Usage:"
  echo "  ./multipagethumb input.pdf output.png"
  exit 1
fi

output="${2%.*}"
n=`pdfinfo $1 | grep Pages: | awk '{print $2}'`

# limit maximal page num
if [ $n -gt 20 ]
then
  n='20'
fi

# shadow oppacity percentage and blur sigma
sperc="80"
ssigma="3"

# shadow offsets, page width and page offsets
sx="6"
sy="6"
w="240"
x="100"
y="2"

#sx="2"
#sy="2"
#w="88"
#x="30"
#y="3"

#sx="3"
#sy="3"
#w="128"
#x="40"
#y="4"

for p in $(seq 1 $n)
do
  p=`echo "$p-1"|bc`
  convert $1[$p] -thumbnail ${w}x -flatten -bordercolor none -border 0 \( +clone \
    -background black -shadow ${sperc}x${ssigma}+${sx}+${sy} \) +swap -background none -layers \
    merge +repage $output-$p.png
  if [[ $p == "0" ]]
  then
    convert $output-$p.png $2
  else
    convert $output.png -gravity SouthEast -background none -splice ${x}x${y} $output.png
    composite -compose dst-over $output-$p.png $output.png -gravity SouthEast $output.png
  fi
  rm $output-$p.png
done
