#!/bin/bash
#FLUX: --job-name=TASKNAME
#FLUX: -t=1680
#FLUX: --urgency=16

gosignal=0
concat_check=$(find -type f -name "*_concat.avi" | wc -l)
if (( $concat_check == 0 )); then
  ID=MYID
  printf "file '%s'\n" *.avi | sort -V > myvidlist.txt
  for f in *.avi; do echo "$f" >> mytarlist.txt; done
  # count the total number of frames in all video files
  original_total=0
  for f in *.avi; do
    numframes=$(ffprobe -v error -select_streams v:0 -show_entries stream=nb_frames -of default=nokey=1:noprint_wrappers=1 $f)
    original_total=$((original_total+$numframes))
  done
  echo "Total frames is $original_total"
  #concatenate all avi files in myvidlist.txt; name it by "animalID_concat.avi"
  ffmpeg -f concat -safe 0 -i myvidlist.txt -c copy $ID.avi
  # count number of frames in new concatenated video
  new_total=$(ffprobe -v error -select_streams v:0 -show_entries stream=nb_frames -of default=nokey=1:noprint_wrappers=1 "$ID.avi")
  #check if concatenated file has as many frames as original avi files
  if (( $new_total > 0 )) && (( $original_total > 0 )) && (( $new_total == $original_total )); then
    echo "Good! $new_total matches $original_total ; tarring files now..."
    tar -cvf behav_videos.tar -T mytarlist.txt
  else
    echo "ERROR: Concatenated file has $new_total frames; does not match original $original_total frames"
  fi
  # if tar file was succesfully created, delete all old avi files
  if [ -f "behav_videos.tar" ]; then
    echo "Everything concatenated and tarred! Deleting files now..."
    xargs rm <mytarlist.txt
    echo "Files deleted!"
    gosignal=1
  fi
elif (( $concat_check == 1 )); then
  echo "concatenaed video file alredy exists! Moving on to DLC analysis..."
  gosignal=1
fi
concat_check_again=$(find -type f -name "*_concat.avi" | wc -l)
if (( $gosignal == 1 )) && (( $concat_check_again == 1 )); then
  rm mytarlist.txt
  module load scipy-stack/2021a
  module load python/3.8
  # source YOUR home directory containing DLC_env
  # e.g., /home/haqqeez/DLC_env/bin/activate
  # leave as (capital letters) envpath if using ParallelDLC.sh
  source ENVPATH
  export DLClight=True
  echo "TESTING GPU"
  nvidia-smi
  echo "RUNNING NOW"
  python DLC_traces.py
else
  echo "ERROR: something went wrong; analysis was not done"
fi
