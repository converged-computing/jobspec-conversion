#!/bin/bash
#FLUX: --job-name=rfm_IMB_Uniband__2_job
#FLUX: -n=4
#FLUX: --exclusive
#FLUX: -t=600
#FLUX: --urgency=16

export SLURM_MPI_TYPE='pmix_v2'
export UCX_NET_DEVICES='mlx5_1:1'

module load gcc/9.3.0-5abm3xg
module load openmpi/4.0.3-qpsxmnc
export SLURM_MPI_TYPE=pmix_v2
export UCX_NET_DEVICES=mlx5_1:1
module load intel-mpi-benchmarks/2019.5-dwg5q6j
srun IMB-MPI1 uniband -npmin 1
