#!/bin/bash
#FLUX: --job-name=dtaScrape
#FLUX: --queue=gpu
#FLUX: -t=10200
#FLUX: --urgency=16

module load python/3.9.1
module load ffmpeg
module list
source /scratch/g/tark/installTesting/dataScraping/envs/whspr/env/bin/activate
model=$1
dirOut=$2
lang=$3
InDir=$4
finSignal=$5
shift 5
file_list=("$@")
for file in "${file_list[@]}"
do
  echo "Processing file: $file"
  echo "whisper $file --model $model --output_dir $dirOut --language $lang"
  whisper $file --model $model --output_dir $dirOut --language $lang
  # Replace this command with the one you want to run on each file
  #echo "whisper_bash $file $model $dirOut $lang $InDir"
  #whisper_bash $file $model $dirOut $lang $InDir
done
deactivate
sig="done"
echo $sig > $finSignal
