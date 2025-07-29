#!/bin/bash
#SBATCH --job-name=doors
#SBATCH --account=conf-gpu-2020.11.23
#SBATCH --output=slurm/%J.out
#SBATCH --error=slurm/%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:v100
#SBATCH --mem=24G
#SBATCH --time=06:00:00
#SBATCH --partition=batch
#SBATCH --constraint=ntasks-per-node=1

conda activate faclab
which conda
which python
python train_walls.py --tuples 3\
		      --notes 'demo' \
		      --lr 0.00001
