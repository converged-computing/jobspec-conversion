#!/bin/bash
#SBATCH --job-name=ant_colony
#SBATCH --output=log_%j.out
#SBATCH --error=log_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=32GB
#SBATCH --time=08:00:00
#SBATCH --constraint=ntasks-per-node=1

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'

module load gnu
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
date
mpiexec ./cmake-build-release-getafix/ant_colony antconfig_megamap_mpi.ini
