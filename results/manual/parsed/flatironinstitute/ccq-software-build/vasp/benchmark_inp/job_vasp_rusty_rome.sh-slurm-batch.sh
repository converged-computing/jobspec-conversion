#!/bin/bash
#SBATCH --job-name=vasp-test-rome
#SBATCH --output=out.%j
#SBATCH --error=err.%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --partition=ccq
#SBATCH --constraint=ntasks-per-node=64,rome

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
ulimit -s unlimited
module purge
module load slurm
module load vasp/6.4.0_nix2_gnu
mpirun --map-by socket:pe=$OMP_NUM_THREADS vasp_std
