#!/bin/bash
#FLUX: --job-name=gassy-leader-4725
#FLUX: --priority=16

date
module purge
module load proteus/1.8.1
mkdir -p $WORK/$SLURM_JOB_NAME.$SLURM_JOBID
cd $WORK/$SLURM_JOB_NAME.$SLURM_JOBID 
cp $SLURM_SUBMIT_DIR/*.py .
cp $SLURM_SUBMIT_DIR/*.csv .
cp $SLURM_SUBMIT_DIR/*.sh .
srun parun -l5 -v -p --TwoPhaseFlow cox_flume2DV.py -C "he=0.02 mangrove_porous=False filename='inp_BL_TI2.csv' final_Time=59.99"
date
exit 0
