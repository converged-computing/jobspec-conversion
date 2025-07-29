#!/bin/bash
#SBATCH --account=uvahydroinformatics
#SBATCH --output=keras_%A_%a.out
#SBATCH --error=keras_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:p100:1
#SBATCH --time=06:00:00
#SBATCH --array=0-19

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
