#!/bin/bash
#FLUX: --job-name=salted-fudge-5134
#FLUX: --priority=16

module purge
module load singularity tensorflow/1.6.0-py36
inputdir=/scratch/$USER/mmps125_bootstraps_storms_fixed
outputdir=/scratch/$USER/mmps125_results_storm_bootstrap_lstm-$SLURM_ARRAY_JOB_ID
mkdir -p $outputdir
fcstoutdir=/scratch/$USER/mmps125_results_storm_bootstrap_fcst_lstm-$SLURM_ARRAY_JOB_ID
mkdir -p $fcstoutdir
shopt -s nullglob
allfiles=($inputdir/*.csv)
fileindex=$SLURM_ARRAY_TASK_ID
while [[ $fileindex -lt ${#allfiles[@]} ]]; do
    # pass the csv file to be processed as first argument
    file=${allfiles[fileindex]}
    echo "processing file # $fileindex: $file, writing to $outputdir"
    singularity-gpu exec /scratch/$USER/tensorflow-1.6.0-py36.simg python /scratch/$USER/keras_mmps125_stormBS_fcst_lstm_rivanna.py "$file" "$outputdir" "$fcstoutdir" #$count
    fileindex=$((fileindex + $SLURM_ARRAY_TASK_COUNT))
done
