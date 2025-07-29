#!/bin/bash
#SBATCH --output=job4.o
#SBATCH --error=job4.e
#SBATCH --nodes=1
#SBATCH --ntasks=100
#SBATCH --cpus-per-task=46
#SBATCH --gres=gpu:8
#SBATCH --time=6-00:00:00
#SBATCH --exclusive
#SBATCH --constraint=ntasks-per-node=8

/bin/bash
conda activate hetero_mod
module load python/3.8.9
module load openmpi/4.1.0/gcc.7.3.1/rocm.4.2
srun --exclusive --nodes 1 --ntasks 1 python dataset_test.py
wait
