#!/bin/bash
#SBATCH --job-name=CUDA_p1
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=v100:1
#SBATCH --mem=1G
#SBATCH --time=00:02:00

module purge
module load gcc/7.3.0-2.30 OpenMPI HDF5
module load NVHPC
srun ./a.out
