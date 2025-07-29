#!/bin/bash
#SBATCH --job-name=r3cdoors
#SBATCH --account=conf-gpu-2020.11.23
#SBATCH --output=slurm/%A_%a.out
#SBATCH --error=slurm/%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:v100
#SBATCH --mem=24G
#SBATCH --time=06:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=0

conda activate faclab
python train_conditional_walls.py --tuples 3 --dec_layer=12 --dim=264 --enc_layer=16 --lr 0.00015
