#!/bin/bash
#SBATCH --job-name=damasktest
#SBATCH --output=damasktest.%J_out
#SBATCH --error=damasktest.%J_err
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1000
#SBATCH --time=00:30:00
#SBATCH --partition=parallel

export DAMASK_NUM_THREADS='1'

module load intelmpi
env > job_env_$SLURM_JOB_ID.txt
export DAMASK_NUM_THREADS=1
ulimit -s unlimited
PATH=$HOME/damask2.0.2/DAMASK/bin:$PATH
LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$HOME/damask2.0.2/petsc-3.9.4/linux-gnu-intel/lib" 
srun $(which DAMASK_spectral)  -l tensionX.load -g RVE.geom
