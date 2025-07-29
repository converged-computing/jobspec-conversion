#!/bin/bash
#SBATCH --output=%x.e%j
#SBATCH --error=%x.e%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=7500
#SBATCH --time=1-00:00:00
#SBATCH --partition=AMG

export OMP_NUM_THREADS='1'
export SCR='/scr/$SLURM_JOB_NAME'

export OMP_NUM_THREADS=1
echo 'JOBNAME' $SLURM_JOB_NAME
echo 'NUM_THREADS' $OMP_NUM_THREADS
hostname
date
module load Compiler/Intel/17u8  Q-Ch/VASP/5.4.4_OPT
export SCR=/scr/$SLURM_JOB_NAME
mkdir -p $SCR
cp ~/vasp/$SLURM_JOB_NAME/* $SCR/
cd $SCR
mpirun -np $SLURM_JOB_CPUS_PER_NODE vasp_std
cp -r $SCR/* ~/vasp/$SLURM_JOB_NAME/
cd ~/vasp/$SLURM_JOB_NAME/
rm -rf $SCR
date
rm -f ~/$SLURM_JOB_NAME.e$SLURM_JOB_ID.err
