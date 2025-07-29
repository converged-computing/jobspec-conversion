#!/bin/bash
#SBATCH --job-name=collagen_segmentation
#SBATCH --output=batch_collagen_seg_testing_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=geforce:1
#SBATCH --mem=175gb
#SBATCH --time=10:00:00
#SBATCH --partition=gpu
#SBATCH --qos=pinaki.sarder

export NEPTUNE_API_TOKEN='eyJhcGlfYWRkcmVzcyI6Imh0dHBzOi8vYXBwLm5lcHR1bmUuYWkiLCJhcGlfdXJsIjoiaHR0cHM6Ly9hcHAubmVwdHVuZS5haSIsImFwaV9rZXkiOiJjNzllZGRmMC0yMzg2LTRhMzktOTk1MC1hNDc2MDlkNjVkYTMifQ=='

pwd; hostname; date
module load singularity
ml
nvidia-smi
export NEPTUNE_API_TOKEN="eyJhcGlfYWRkcmVzcyI6Imh0dHBzOi8vYXBwLm5lcHR1bmUuYWkiLCJhcGlfdXJsIjoiaHR0cHM6Ly9hcHAubmVwdHVuZS5haSIsImFwaV9rZXkiOiJjNzllZGRmMC0yMzg2LTRhMzktOTk1MC1hNDc2MDlkNjVkYTMifQ=="
singularity exec --nv collagen_segmentation_latest.sif python3 batch_predictions.py
date
