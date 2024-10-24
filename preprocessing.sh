#!/bin/sh

cd whisper.cpp

audio_pattern="../input_raw/*.wav"
text_pattern="../input_raw/*.txt"
target_pattern="../input/"
args=""


for file in $audio_pattern
do
    args="$args $file -otxt"
done

if [ -n "$args" ]; then
    ./main $args
else
    echo "No .txt files in the directory"
fi

for file in $text_pattern
do
    cp $file $target_pattern;
    rm $file
done

cd ..