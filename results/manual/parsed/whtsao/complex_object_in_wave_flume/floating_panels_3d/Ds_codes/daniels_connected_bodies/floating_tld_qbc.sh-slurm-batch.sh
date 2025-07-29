#!/bin/bash
#SBATCH --job-name=emi2023_3d_floating_tld
#SBATCH --account=loni_proteus01s
#SBATCH --output=o.out
#SBATCH --error=e.err
#SBATCH --nodes=8
#SBATCH --ntasks=384
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --partition=workq

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
