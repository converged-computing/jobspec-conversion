#!/bin/bash
#SBATCH --job-name=dtaScrape
#SBATCH --account=tark
#SBATCH --output=/scratch/g/tark/installTesting/dataScraping/output/%x-%j.out
#SBATCH --mail-user=eduwell@mcw.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=10gb
#SBATCH --time=02:50:00
#SBATCH --partition=gpu

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
