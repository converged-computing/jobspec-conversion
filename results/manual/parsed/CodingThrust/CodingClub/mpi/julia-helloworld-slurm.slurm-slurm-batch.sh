#!/bin/bash
#SBATCH --job-name=mpi_job
#SBATCH --output=log.%j
#SBATCH --nodes=1
#SBATCH --ntasks=128
#SBATCH --cpus-per-task=1
#SBATCH --time=10:00:00

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

module load mpi/openmpi-4.1.5
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
mpirun $HOME/.juliaup/bin/julia --project=$PWD mpi.jl
