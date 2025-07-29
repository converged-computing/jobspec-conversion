#!/bin/bash
#SBATCH --job-name=rfm_IMB_Biband_0_75_job
#SBATCH --output=rfm_IMB_Biband_0_75_job.out
#SBATCH --error=rfm_IMB_Biband_0_75_job.err
#SBATCH --nodes=1
#SBATCH --ntasks=24
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --exclusive
#SBATCH --constraint=ntasks-per-node=12

export SLURM_MPI_TYPE='pmix_v3'

export SLURM_MPI_TYPE=pmix_v3
spack load intel-mpi-benchmarks
srun IMB-MPI1 biband -npmin 1
