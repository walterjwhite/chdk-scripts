#!/bin/sh

for f in *.JPG;do convert $f -rotate 180 rotated/$f;done
