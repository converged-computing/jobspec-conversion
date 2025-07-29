#!/bin/bash
#SBATCH --job-name=test-learner
#SBATCH --output=test-learner
#SBATCH --mail-user=mahyar.karimi@ist.ac.at
#SBATCH --mail-type=fail
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=4G
#SBATCH --time=01:00:00

module purge
module load cuda/11.7
module load python/3.10
python -m ...
