#!/bin/bash
#SBATCH --job-name=rfm_Osu_mbw_mr__4_job
#SBATCH --account=support-cpu
#SBATCH --output=rfm_Osu_mbw_mr__4_job.out
#SBATCH --error=rfm_Osu_mbw_mr__4_job.err
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --time=00:15:00
#SBATCH --exclusive
#SBATCH --constraint=ntasks-per-node=4
#SBATCH --exclude=cpu-p-[1-280,337-672]

export SLURM_MPI_TYPE='pmix_v3'
export UCX_NET_DEVICES='mlx5_0:1'

module load openmpi-3.1.6-gcc-9.1.0-omffmfv
export SLURM_MPI_TYPE=pmix_v3
export UCX_NET_DEVICES=mlx5_0:1
module load osu-micro-benchmarks-5.6.3-gcc-9.1.0-nsxydkj
srun osu_mbw_mr
