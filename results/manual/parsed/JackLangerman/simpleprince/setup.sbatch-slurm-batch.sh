#!/bin/bash
#SBATCH --job-name=setup
#SBATCH --output=setup.out
#SBATCH --error=setup.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu
#SBATCH --mem=12GB
#SBATCH --time=00:15:00

module load tensorflow/python3.6/1.5.0
module swap python3/intel  anaconda3/5.3.1
cd ~/simpleprince
conda env create
