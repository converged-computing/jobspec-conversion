#!/bin/bash
#FLUX: --job-name=rfm_IMB_Biband_0_5_job
#FLUX: -n=32
#FLUX: --exclusive
#FLUX: -t=600
#FLUX: --urgency=16

export SLURM_MPI_TYPE='pmix_v2'
export UCX_NET_DEVICES='mlx5_0:1'

module load gcc/9.3.0-5abm3xg
module load openmpi/4.0.3-qpsxmnc
export SLURM_MPI_TYPE=pmix_v2
export UCX_NET_DEVICES=mlx5_0:1
module load intel-mpi-benchmarks/2019.5-dwg5q6j
srun IMB-MPI1 biband -npmin 1
