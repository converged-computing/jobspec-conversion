#!/bin/bash
#FLUX: --job-name=rfm_Osu_mbw_mr__4_job
#FLUX: -n=8
#FLUX: --exclusive
#FLUX: --queue=cclake
#FLUX: -t=900
#FLUX: --urgency=16

export SLURM_MPI_TYPE='pmix_v3'
export UCX_NET_DEVICES='mlx5_0:1'

module load openmpi-3.1.6-gcc-9.1.0-omffmfv
export SLURM_MPI_TYPE=pmix_v3
export UCX_NET_DEVICES=mlx5_0:1
module load osu-micro-benchmarks-5.6.3-gcc-9.1.0-nsxydkj
srun osu_mbw_mr
