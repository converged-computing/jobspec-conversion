#!/bin/bash
#SBATCH --job-name=plasma-python
#SBATCH --account=Magnetic-Confinement
#SBATCH --output=plasma.o%j
#SBATCH --error=plasma.e%j
#SBATCH --mail-user=michoski@gmail.com
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=20
#SBATCH --cpus-per-task=1
#SBATCH --time=05:00:00

module load gcc/4.9.3
module load python3/3.5.2
module load cuda/8.0
module load cudnn/5.1
module load tensorflow-gpu/1.0.0
module load mvapich2
module load git
ibrun python3 mpi_learn.py
