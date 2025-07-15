#!/bin/bash
#FLUX: --job-name=frigid-pedo-4483
#FLUX: -N=2
#FLUX: -n=40
#FLUX: -t=60
#FLUX: --urgency=16

set -x
echo $SLURM_JOB_NODELIST
cd $SLURM_SUBMIT_DIR
ulimit -s unlimited
srun --mpi=pmix --cpu_bind=verbose,core -n $SLURM_NTASKS ping_pong_advanced2_ssend > ssend.dat
srun --mpi=pmix --cpu_bind=verbose,core -n $SLURM_NTASKS ping_pong_advanced2_send > send.dat
