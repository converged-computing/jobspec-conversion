#!/bin/bash
#SBATCH --job-name=gnn_2_1
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:32gb:1
#SBATCH --mem=16G
#SBATCH --time=2-00:00:00

export PYTHONUNBUFFERED='1'

export PYTHONUNBUFFERED=1
module load cuda/10.2
module load anaconda
conda activate diffsub
python main.py with configs/zinc/node_del/del1_subgraph1_imle.yaml
