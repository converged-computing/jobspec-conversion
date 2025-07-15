#!/bin/bash
#FLUX: --job-name=doopy-lemur-8331
#FLUX: --priority=16

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
