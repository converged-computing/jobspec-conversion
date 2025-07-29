#!/bin/bash
#SBATCH --job-name=NRE_train
#SBATCH --output=logs/NRE_train.out
#SBATCH --mail-user=gz612@nyu.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=100GB
#SBATCH --time=2-00:00:00

module purge
module load python3/intel/3.5.3
module load tensorflow/python3.5/1.0.1 cuda/8.0.44
python3 -u train_GRU.py > logs/NRE_train.log
