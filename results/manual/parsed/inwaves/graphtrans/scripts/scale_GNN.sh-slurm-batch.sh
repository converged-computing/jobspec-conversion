#!/bin/bash
#SBATCH --job-name=baseline-generalisation-experiments
#SBATCH --account=KRUEGER-SL3-GPU
#SBATCH --output=slurm-out/%x.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --time=02:00:00
#SBATCH --partition=ampere

python main.py --configs configs/NCI1/gcn/scaled_layers_constant_embedding.yml
python main.py --configs configs/NCI1/gcn/scaled_embedding_constant_layers.yml
python main.py --configs configs/NCI1/gcn/scaled_layers_scaled_embedding.yml
python main.py --configs configs/NCI109/gcn/scaled_layers_constant_embedding.yml
python main.py --configs configs/NCI109/gcn/scaled_embedding_constant_layers.yml
python main.py --configs configs/NCI109/gcn/scaled_layers_scaled_embedding.yml
