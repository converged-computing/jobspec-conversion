#!/bin/bash
#FLUX: --job-name=cox_2D_BL_tr4
#FLUX: -N=4
#FLUX: -n=192
#FLUX: --queue=workq
#FLUX: -t=259200
#FLUX: --urgency=16

date
module purge
module load proteus/1.8.1
mkdir -p $WORK/$SLURM_JOB_NAME.$SLURM_JOBID
cd $WORK/$SLURM_JOB_NAME.$SLURM_JOBID 
cp $SLURM_SUBMIT_DIR/*.py .
cp $SLURM_SUBMIT_DIR/*.csv .
cp $SLURM_SUBMIT_DIR/*.sh .
srun parun -l5 -v -p --TwoPhaseFlow cox_flume2DV.py -C "he=0.02 mangrove_porous=False filename='inp_BL_TR4.csv' final_Time=59.99"
date
exit 0
