#!/bin/bash
#SBATCH --job-name=save_whisper_ewc_params
#SBATCH --account=DUDLEY-SL3-GPU
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=07:00:00
#SBATCH --partition=ampere

LOGDIR=logs/
DIRPATH_EXP=logs/$SLURM_JOB_NAME/
mkdir -p $DIRPATH_EXP
LOG=$DIRPATH_EXP/$SLURM_JOB_ID.log
ERR=$DIRPATH_EXP/$SLURM_JOB_ID.err
echo -e "JobID: $SLURM_JOB_ID\n======" > $LOG
echo "Time: `date`" >> $LOG
echo "Running on master node: `hostname`" >> $LOG
echo "python `which python`": >> $LOG
python scripts/save_whisper_ewc_params.py \
    openai/whisper-tiny \
    --language french \
    --task transcribe \
    --dataset-name mls_french_diagnostic \
    --split train \
    >> $LOG 2> $ERR
echo "Time: `date`" >> $LOG
