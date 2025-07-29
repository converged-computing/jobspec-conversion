#!/bin/bash
#SBATCH --account=m844
#SBATCH --output=qout.256.%j
#SBATCH --error=qout.256.%j
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00
#SBATCH --qos=debug
#SBATCH --constraint=cpu

if test "x$SLURM_NTASKS_PER_NODE" = x ; then
   SLURM_NTASKS_PER_NODE=128
fi
NUM_NODES=$SLURM_JOB_NUM_NODES
NP=$((NUM_NODES * SLURM_NTASKS_PER_NODE))
ulimit -c unlimited
srun -n $NP podman-hpc run -w /work -v $PWD:/work --rm --mpi yzanhua/perlmutter_img:latest python3 hello.py
