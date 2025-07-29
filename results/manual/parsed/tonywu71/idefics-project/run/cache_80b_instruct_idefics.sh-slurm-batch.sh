#!/bin/bash
#SBATCH --job-name=cache_80b_instruct_idefics
#SBATCH --account=MLMI-tw581-SL2-CPU
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --partition=cclake-himem

LOGDIR=logs/
DIRPATH_EXP=logs/$SLURM_JOB_NAME/
mkdir -p $DIRPATH_EXP
LOG=$DIRPATH_EXP/$SLURM_JOB_ID.log
ERR=$DIRPATH_EXP/$SLURM_JOB_ID.err
echo -e "JobID: $SLURM_JOB_ID\n======" > $LOG
echo "Time: `date`" >> $LOG
echo "Running on master node: `hostname`" >> $LOG
echo "python `which python`": >> $LOG
python scripts/cache_model.py \
    --idefics-config-path HuggingFaceM4/idefics-80b-instruct \
    >> $LOG 2> $ERR
echo "Time: `date`" >> $LOG
