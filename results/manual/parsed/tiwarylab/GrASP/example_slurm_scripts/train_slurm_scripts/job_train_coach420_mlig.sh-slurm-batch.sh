#!/bin/bash
#SBATCH --job-name=scPDB -s coach420_mlig -ag multi
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=v100-32:4
#SBATCH --time=08:00:00
#SBATCH --partition=GPU-shared
#SBATCH --constraint=ntasks-per-node=8

module load anaconda3
conda activate # source /opt/packages/anaconda3/etc/profile.d/conda.sh
module load cuda/11.7.1
conda activate pytorch_env
python3 train.py -s coach420_mlig -ag multi
