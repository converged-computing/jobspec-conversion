#!/bin/bash
#FLUX: --job-name=faux-bicycle-1680
#FLUX: -n=40
#FLUX: --exclusive
#FLUX: -t=60
#FLUX: --priority=16

set -x
echo $SLURM_JOB_NODELIST
cd $SLURM_SUBMIT_DIR
ulimit -s unlimited
srun --mpi=pmix --cpu_bind=verbose,core -n $SLURM_NTASKS ping_pong_advanced2_ssend > ssend.dat
srun --mpi=pmix --cpu_bind=verbose,core -n $SLURM_NTASKS ping_pong_advanced2_send > send.dat
