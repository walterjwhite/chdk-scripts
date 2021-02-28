#!/bin/sh

ffmpeg -framerate 30 -pattern_type glob -i "rotated/*.JPG" -s:v 1920x1080 -c:v libx264 -crf 17 -pix_fmt yuv420p timelapse.mp4
