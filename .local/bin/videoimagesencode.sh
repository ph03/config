#!/bin/sh
# Script for encoding videos using high quality H.264 codec and ffmpeg from images.
# Usage: ./videoimagesencode.sh %d.png 24 outname.mp4

FFCOMMON="-vcodec libx264 -b:v 20000k -threads 0 -q:v 0 -preset medium -tune animation -profile:v high -pix_fmt yuv420p"
FFMPEG="ffmpeg"

${FFMPEG} -framerate ${2} -i ${1} ${FFCOMMON} -pass 1 -f rawvideo -an -y /dev/null && ${FFMPEG} -framerate ${2} -i ${1} ${FFCOMMON} -pass 2 -y ${3}
rm ffmpeg2pass-0.log ffmpeg2pass-0.log.mbtree x264_2pass.log x264_2pass.log.mbtree av2pass-0.log av2pass-0.log.mbtree &> /dev/null
