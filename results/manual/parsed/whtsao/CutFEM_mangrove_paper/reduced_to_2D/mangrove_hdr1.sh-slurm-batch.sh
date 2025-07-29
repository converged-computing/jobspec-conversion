#!/bin/bash
#FLUX: --job-name=cox_2D_HD_r1
#FLUX: -N=16
#FLUX: -n=768
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
srun parun -l5 -v -p --TwoPhaseFlow cox_flume2DV.py -C "he=0.06 mangrove_porous=True filename='inp_HD_TR1.csv'"
date
exit 0
