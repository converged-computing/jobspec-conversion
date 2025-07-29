#!/bin/bash
#SBATCH --output=LOG_FILE.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=00:10:00
#SBATCH --partition=gpu

module load matlab/r2019b
srun matlab -nojvm -nosplash -batch "testBench()"
