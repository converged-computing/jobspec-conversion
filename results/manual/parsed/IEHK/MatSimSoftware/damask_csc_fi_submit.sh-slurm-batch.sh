#!/bin/bash
#FLUX: --job-name=damasktest
#FLUX: -n=4
#FLUX: --queue=parallel
#FLUX: -t=1800
#FLUX: --urgency=16

export DAMASK_NUM_THREADS='1'

module load intelmpi
env > job_env_$SLURM_JOB_ID.txt
export DAMASK_NUM_THREADS=1
ulimit -s unlimited
PATH=$HOME/damask2.0.2/DAMASK/bin:$PATH
LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$HOME/damask2.0.2/petsc-3.9.4/linux-gnu-intel/lib" 
srun $(which DAMASK_spectral)  -l tensionX.load -g RVE.geom
