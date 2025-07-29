#!/bin/bash
#SBATCH --job-name=run_md
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=8GB
#SBATCH --time=1-00:00:00

module purge
module load gromacs/openmpi/intel/2020.4
mpirun gmx_mpi mdrun -deffnm ../Setup/md_0_1
