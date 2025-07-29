#!/bin/bash
#SBATCH --job-name=vasp-test-rome
#SBATCH --output=out.%j
#SBATCH --error=err.%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=32,rome

export OMP_NUM_THREADS='4'

export OMP_NUM_THREADS=4
ulimit -s unlimited
module purge
module load vasp/6.3.0_nixpack_gnu slurm
mpirun --map-by socket:pe=$OMP_NUM_THREADS vasp_std
