#!/bin/bash
#FLUX: --job-name=gassy-platanos-7582
#FLUX: -n=2
#FLUX: --exclusive
#FLUX: -t=600
#FLUX: --priority=16

export SLURM_MPI_TYPE='pmix_v2'
export UCX_NET_DEVICES='mlx5_0:1'

nodes=$(scontrol show hostnames $SLURM_JOB_NODELIST)
module load gcc/9.3.0-5abm3xg
module load openmpi/4.0.3-qpsxmnc
export SLURM_MPI_TYPE=pmix_v2
export UCX_NET_DEVICES=mlx5_0:1
module load intel-mpi-benchmarks/2019.5-dwg5q6j
srun IMB-MPI1 pingpong
