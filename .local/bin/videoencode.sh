#!/bin/sh
# Script for encoding videos using high quality H.264 codec and ffmpeg.

FFCOMMON="-vcodec libx264 -b 2000k -threads 0 -sameq -preset medium -tune animation -profile high"
NICENESS=19
FFMPEG="avconv"

nice -n ${NICENESS} ${FFMPEG} -i ${1} ${FFCOMMON} -pass 1 -f rawvideo -an -y /dev/null && nice -n ${NICENESS} ${FFMPEG} -i ${1} ${FFCOMMON} -pass 2 -an -y ${2}
rm ffmpeg2pass-0.log x264_2pass.log x264_2pass.log.mbtree av2pass-0.log av2pass-0.log.mbtree &> /dev/null
