#!/bin/bash
#SBATCH --job-name=rfm_IMB_Uniband_0_25_job
#SBATCH --account=support-cpu
#SBATCH --output=rfm_IMB_Uniband_0_25_job.out
#SBATCH --error=rfm_IMB_Uniband_0_25_job.err
#SBATCH --nodes=1
#SBATCH --ntasks=28
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --exclusive
#SBATCH --constraint=ntasks-per-node=14
#SBATCH --exclude=cpu-p-[1-280,337-672]

export SLURM_MPI_TYPE='pmix_v3'
export UCX_NET_DEVICES='mlx5_0:1'

module load openmpi-3.1.6-gcc-9.1.0-omffmfv
export SLURM_MPI_TYPE=pmix_v3
export UCX_NET_DEVICES=mlx5_0:1
module load intel-mpi-benchmarks-2019.6-gcc-9.1.0-5tbknir
srun IMB-MPI1 uniband -npmin 1
