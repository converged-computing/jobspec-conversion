#!/bin/bash
#SBATCH --output=%j.out
#SBATCH --error=%j.err
#SBATCH --mail-user=augustin_luna@hms.harvard.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:teslaK80:2
#SBATCH --time=06:00:00

module load gcc/6.2.0
module load python/3.7.4
module load cuda/10.0
pipenv run python mnist_cnn_gpu.py
