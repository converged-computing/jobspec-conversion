#!/bin/bash
#FLUX: --job-name=dinosaur-poodle-4110
#FLUX: --queue=gpu
#FLUX: -t=21600
#FLUX: --urgency=16

module purge
module load singularity tensorflow/1.6.0-py36
inputdir=/scratch/$USER/mmps170_bootstraps_shifted
outputdir=/scratch/$USER/mmps170_results_full_bootstrap_rnn-$SLURM_ARRAY_JOB_ID
mkdir -p $outputdir
fcstoutdir=/scratch/$USER/mmps170_results_full_bootstrap_fcst_rnn-$SLURM_ARRAY_JOB_ID
mkdir -p $fcstoutdir
shopt -s nullglob
allfiles=($inputdir/*.csv)
fileindex=$SLURM_ARRAY_TASK_ID
while [[ $fileindex -lt ${#allfiles[@]} ]]; do
    # pass the csv file to be processed as first argument
    file=${allfiles[fileindex]}
    echo "processing file # $fileindex: $file, writing to $outputdir"
    singularity-gpu exec /scratch/$USER/tensorflow-1.6.0-py36.simg python /scratch/$USER/keras_mmps170_fullBS_fcst_rnn_rivanna.py "$file" "$outputdir" "$fcstoutdir" #$count
    fileindex=$((fileindex + $SLURM_ARRAY_TASK_COUNT))
done
