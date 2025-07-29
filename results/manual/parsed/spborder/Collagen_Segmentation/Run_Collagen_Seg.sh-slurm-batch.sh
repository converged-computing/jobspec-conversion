#!/bin/bash
#SBATCH --job-name=collagen_segmentation
#SBATCH --output=collagen_seg_training_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=geforce:1
#SBATCH --mem=80gb
#SBATCH --time=1-01:00:00
#SBATCH --qos=pinaki.sarder

export NEPTUNE_API_TOKEN='eyJhcGlfYWRkcmVzcyI6Imh0dHBzOi8vYXBwLm5lcHR1bmUuYWkiLCJhcGlfdXJsIjoiaHR0cHM6Ly9hcHAubmVwdHVuZS5haSIsImFwaV9rZXkiOiJjNzllZGRmMC0yMzg2LTRhMzktOTk1MC1hNDc2MDlkNjVkYTMifQ=='

pwd; hostname; date
module load singularity
ml
date
nvidia-smi
export NEPTUNE_API_TOKEN="eyJhcGlfYWRkcmVzcyI6Imh0dHBzOi8vYXBwLm5lcHR1bmUuYWkiLCJhcGlfdXJsIjoiaHR0cHM6Ly9hcHAubmVwdHVuZS5haSIsImFwaV9rZXkiOiJjNzllZGRmMC0yMzg2LTRhMzktOTk1MC1hNDc2MDlkNjVkYTMifQ=="
singularity exec --nv collagen_segmentation_latest.sif python3 Collagen_Segmentation/CollagenSegMain.py train_inputs_single.json
date
