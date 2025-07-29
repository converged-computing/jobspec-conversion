#!/bin/bash
#SBATCH --output=results/gpujob.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:p100:1
#SBATCH --mem=16GB
#SBATCH --time=01:00:00

module purge
module load nvidia-hpc-sdk
./go 50 384 6
./go 100 384 6
./go 200 384 6
./go 400 384 6
./go 800 384 6
./go 1000 384 6
