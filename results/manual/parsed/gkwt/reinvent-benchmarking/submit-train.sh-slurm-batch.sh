#!/bin/bash
#SBATCH --account=def-aspuru
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:1
#SBATCH --mem=12000M
#SBATCH --time=00:01:00

module load python/3.6 scipy-stack
module load StdEnv/2020 gcc/9.3.0
module load rdkit/2021.03.3
source  ~/env/reinvent/bin/activate
time python train_prior.py --num-epochs 100 # --verbose
deactivate
