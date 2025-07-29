#!/bin/bash
#SBATCH --job-name=xxx
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=200M
#SBATCH --time=30-00:00:00
#SBATCH --constraint=ntasks-per-node=40,ntasks-per-socket=20

cd $SLURM_SUBMIT_DIR
module load openmpi
module load openblas
module load fftw3
module load lammps/gcc/sfft/openmpi/cuda/2Aug23.3
mpiexec --bind-to core --map-by core -n 40 lmp_mpi -i input.lmps
module purge
