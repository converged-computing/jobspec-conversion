#!/bin/bash
#SBATCH --job-name=rfm_Sysinfo_job
#SBATCH --output=rfm_Sysinfo_job.out
#SBATCH --error=rfm_Sysinfo_job.err
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --constraint=ntasks-per-node=1

export SLURM_MPI_TYPE='pmix_v3'

export SLURM_MPI_TYPE=pmix_v3
srun python sysinfo.py
echo Done
