#!/bin/bash
#SBATCH --job-name=simsopt
#SBATCH --account=apam
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=170gb
#SBATCH --time=00:05:00
#SBATCH --constraint=ntasks-per-node=8

export OMP_NUM_THREADS='4'

source ~/.bashrc
module load gcc/10.2.0
module load openmpi/gcc/64/4.1.5a1
module load anaconda
conda activate simsopt_072523
export OMP_NUM_THREADS=4
srun --mpi=pmix_v3 python trapped_map.py
