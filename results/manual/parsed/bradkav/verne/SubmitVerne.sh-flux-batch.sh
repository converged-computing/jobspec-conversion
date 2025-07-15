#!/bin/bash
#FLUX: --job-name=bumfuzzled-parsnip-5412
#FLUX: --priority=16

export SLURM_CPU_BIND='none'

cd $HOME/verne/
module load pre2019
module unload GCCcore
module load Python/2.7.12-intel-2016b
module load slurm-tools
export SLURM_CPU_BIND=none
time mpirun -np 16 python2.7 RunMPI_verne.py -target MOD -index $1
