#!/bin/bash
#SBATCH --job-name=eval_whisper_on_fad-vanilla
#SBATCH --account=MLMI-tw581-SL2-GPU
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=00:40:00

LOGDIR=logs/
DIRPATH_EXP=logs/$SLURM_JOB_NAME/
mkdir -p $DIRPATH_EXP
LOG=$DIRPATH_EXP/$SLURM_JOB_ID.log
ERR=$DIRPATH_EXP/$SLURM_JOB_ID.err
echo -e "JobID: $JOBID\n======" > $LOG
echo "Time: `date`" >> $LOG
echo "Running on master node: `hostname`" >> $LOG
echo "python `which python`": >> $LOG
python scripts/eval_whisper.py \
    openai/whisper-tiny \
    --dataset-name fad \
    --batch-size 1024 \
    >> $LOG 2> $ERR
echo "Time: `date`" >> $LOG
