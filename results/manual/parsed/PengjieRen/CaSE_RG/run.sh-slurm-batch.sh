#!/bin/bash
#SBATCH --job-name=$1
#SBATCH --output=./$1.$2-%A.out
#SBATCH --error=./$1.$2-%A.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:4
#SBATCH --mem=180G
#SBATCH --time=4-00:00:00
#SBATCH --nodelist=$3

sbatch <<EOT
source ${HOME}/.bashrc
conda activate python3.7
set PYTHONPATH=./
python -m torch.distributed.launch --nproc_per_node=4 ./$1/Run.py --mode='$2' --data_path='$4' --dataset='$5'
EOT
