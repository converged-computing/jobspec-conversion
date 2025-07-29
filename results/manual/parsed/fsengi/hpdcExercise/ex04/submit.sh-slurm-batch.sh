#!/bin/bash
#SBATCH --job-name=mmul_sequential
#SBATCH --output=mmul.out
#SBATCH --error=mmul.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:00:10
#SBATCH --constraint=ntasks-per-node=1

module load devtoolset/10 mpi/open-mpi-4.0.5
srun ./heat >> data.txt
