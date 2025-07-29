#!/bin/bash
#SBATCH --job-name=parallel_hdf5_2d
#SBATCH --output=parallel_hdf5_2d.out
#SBATCH --error=parallel_hdf5_2d.err
#SBATCH --nodes=2
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4000
#SBATCH --time=00:10:00
#SBATCH --partition=test

module load intel/21.2.0-fasrc01 openmpi/4.1.1-fasrc01 hdf5/1.12.1-fasrc01
srun -n $SLURM_NTASKS -N $SLURM_NNODES --mpi=pmix ./parallel_hdf5_2d.x
