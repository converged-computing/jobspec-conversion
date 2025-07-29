#!/bin/bash
#SBATCH --account=exasgd
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=00:59:00

module load cmake/3.15.3
module load gcc/7.5.0
module load cuda/11.1
srun ./run_Ruiz 
