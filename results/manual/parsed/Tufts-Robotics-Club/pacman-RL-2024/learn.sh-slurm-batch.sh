#!/bin/bash
#SBATCH --job-name=PacLearn
#SBATCH --output=pacbot-learn.%j.out
#SBATCH --error=pacbot-learn.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a100:1
#SBATCH --mem-per-cpu=16g
#SBATCH --time=06:00:00

module purge
hostname
module load anaconda/2021.05
module load cuda/12.2
module list
source activate cupy
python -m src
conda deactivate
