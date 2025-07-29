#!/bin/bash
#SBATCH --job-name=mpi_test
#SBATCH --account=pdc.staff
#SBATCH --output=slurm-%j.out
#SBATCH --error=slurm-%j.err
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00
#SBATCH --constraint=ntasks-per-node=128

srun --ntasks=1 singularity exec ./mpi-bw-hybrid.sif bash -c 'ldd /mpiapp/mpi_bandwidth'
srun --mpi=pmi2 -n 256 singularity exec ./mpi-bw-hybrid.sif bash -c '/mpiapp/mpi_bandwidth'
