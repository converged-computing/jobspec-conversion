#!/bin/bash
#SBATCH --job-name=distil_tac-experiment
#SBATCH --account=MLMI-tw581-SL2-GPU
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=00:20:00
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
python scripts/finetune_whisper.py \
    configs/finetune_tac_configs/debug/finetune_tac-tiny-debug.yaml \
    --tac \
    >> $LOG 2> $ERR
echo "Time: `date`" >> $LOG
