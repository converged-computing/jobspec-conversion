#!/bin/bash
#FLUX: --job-name=emi2023_3d_floating_tld
#FLUX: -N=8
#FLUX: -n=384
#FLUX: --queue=workq
#FLUX: -t=3600
#FLUX: --urgency=16

date
module purge
module load proteus/1.8.1
mkdir -p $WORK/$SLURM_JOB_NAME.$SLURM_JOBID
cd $WORK/$SLURM_JOB_NAME.$SLURM_JOBID 
cp $SLURM_SUBMIT_DIR/*.stl .
cp $SLURM_SUBMIT_DIR/*.py .
cp $SLURM_SUBMIT_DIR/*.sh .
srun parun TN_with_box_so.py -F -l 5 -C "he=1. T=1."  #-O petsc.options.asm
date
exit 0
