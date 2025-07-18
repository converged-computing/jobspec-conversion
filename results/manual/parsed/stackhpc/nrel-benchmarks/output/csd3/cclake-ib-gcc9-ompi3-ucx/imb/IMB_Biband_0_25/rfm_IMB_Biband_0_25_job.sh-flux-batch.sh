#!/bin/bash
#FLUX: --job-name=rfm_IMB_Biband_0_25_job
#FLUX: -n=28
#FLUX: --exclusive
#FLUX: --queue=cclake
#FLUX: -t=600
#FLUX: --urgency=16

export SLURM_MPI_TYPE='pmix_v3'
export UCX_NET_DEVICES='mlx5_0:1'

module load openmpi-3.1.6-gcc-9.1.0-omffmfv
export SLURM_MPI_TYPE=pmix_v3
export UCX_NET_DEVICES=mlx5_0:1
module load intel-mpi-benchmarks-2019.6-gcc-9.1.0-5tbknir
srun IMB-MPI1 biband -npmin 1
