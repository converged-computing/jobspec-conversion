#!/bin/bash
#SBATCH --output=slurm_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1024
#SBATCH --time=00:01:00
#SBATCH --partition=general
#SBATCH --qos=short

module use /opt/insy/modulefiles          # Use DAIC INSY software collection
module load openmpi
srun julia hello_mpi.jl > hello_mpi.log
