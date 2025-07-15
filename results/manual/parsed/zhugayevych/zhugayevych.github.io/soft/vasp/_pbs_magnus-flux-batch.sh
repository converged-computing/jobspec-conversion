#!/bin/bash
#FLUX: --job-name=persnickety-peanut-0019
#FLUX: --urgency=16

export SCR='/scr/$SLURM_JOB_USER/$SLURM_JOB_ID'

echo 'JOB_NAME' $SLURM_JOB_NAME
echo 'JOB_ID' $SLURM_JOB_ID
echo 'JOB_CPUS_PER_NODE' $SLURM_JOB_CPUS_PER_NODE
hostname
date
module load Compiler/Intel/17u8  Q-Ch/VASP/5.4.4_OPT
export SCR=/scr/$SLURM_JOB_USER/$SLURM_JOB_ID
echo 'SCR' $SCR
mkdir -p $SCR
cp ~/vasp/$SLURM_JOB_NAME/* $SCR/
cd $SCR
mpirun -np $SLURM_JOB_CPUS_PER_NODE vasp_std
cp -r $SCR/* ~/vasp/$SLURM_JOB_NAME/
cd ~/vasp/$SLURM_JOB_NAME/
rm -rf $SCR
date
rm -f ~/$SLURM_JOB_NAME.e$SLURM_JOB_ID.err
