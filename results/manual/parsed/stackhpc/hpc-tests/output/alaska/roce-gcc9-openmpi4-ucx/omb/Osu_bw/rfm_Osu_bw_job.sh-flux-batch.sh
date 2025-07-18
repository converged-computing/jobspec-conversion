#!/bin/bash
#FLUX: --job-name=rfm_Osu_bw_job
#FLUX: -n=2
#FLUX: --exclusive
#FLUX: -t=600
#FLUX: --urgency=16

export SLURM_MPI_TYPE='pmix_v2'
export UCX_NET_DEVICES='mlx5_1:1'

module load gcc/9.3.0-5abm3xg
module load openmpi/4.0.3-qpsxmnc
export SLURM_MPI_TYPE=pmix_v2
export UCX_NET_DEVICES=mlx5_1:1
module load osu-micro-benchmarks/5.6.2-vx3wtzo
srun osu_bw
