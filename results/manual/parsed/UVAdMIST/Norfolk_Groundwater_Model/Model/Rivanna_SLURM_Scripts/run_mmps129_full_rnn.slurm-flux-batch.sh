#!/bin/bash
#FLUX: --job-name=bumfuzzled-lettuce-5406
#FLUX: --priority=16

module purge
module load singularity tensorflow/1.6.0-py36
inputdir=/scratch/$USER/mmps129_bootstraps
outputdir=/scratch/$USER/mmps129_results_full_bootstrap_rnn-$SLURM_ARRAY_JOB_ID
mkdir -p $outputdir
fcstoutdir=/scratch/$USER/mmps129_results_full_bootstrap_fcst_rnn-$SLURM_ARRAY_JOB_ID
mkdir -p $fcstoutdir
shopt -s nullglob
allfiles=($inputdir/*.csv)
fileindex=$SLURM_ARRAY_TASK_ID
while [[ $fileindex -lt ${#allfiles[@]} ]]; do
    # pass the csv file to be processed as first argument
    file=${allfiles[fileindex]}
    echo "processing file # $fileindex: $file, writing to $outputdir"
    singularity-gpu exec /scratch/$USER/tensorflow-1.6.0-py36.simg python /scratch/$USER/keras_mmps129_fullBS_fcst_rnn_rivanna.py "$file" "$outputdir" "$fcstoutdir" #$count
    fileindex=$((fileindex + $SLURM_ARRAY_TASK_COUNT))
done
