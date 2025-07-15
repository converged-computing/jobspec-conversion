#!/bin/bash
#FLUX: --job-name=swampy-staircase-5775
#FLUX: --urgency=16

if test "x$SLURM_NTASKS_PER_NODE" = x ; then
   SLURM_NTASKS_PER_NODE=128
fi
NUM_NODES=$SLURM_JOB_NUM_NODES
NP=$((NUM_NODES * SLURM_NTASKS_PER_NODE))
ulimit -c unlimited
srun -n $NP podman-hpc run -w /work -v $PWD:/work --rm --mpi yzanhua/perlmutter_img:latest python3 hello.py
