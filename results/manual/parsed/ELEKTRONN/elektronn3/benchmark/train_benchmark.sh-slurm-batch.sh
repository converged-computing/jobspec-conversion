#!/bin/bash
#SBATCH --job-name=E3_TRAIN_GPU_TEST
#SBATCH --output=./train-out.%j
#SBATCH --error=./train-err.%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=04:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --chdir=./

module purge
module load anaconda/3/2020.02
conda activate e3
srun python3 ./train_benchmark.py --jit=disabled
srun python3 ./train_benchmark.py --jit=disabled --amp
srun python3 ./train_benchmark.py --jit=disabled --dp
srun python3 ./train_benchmark.py --jit=disabled --dp --amp
