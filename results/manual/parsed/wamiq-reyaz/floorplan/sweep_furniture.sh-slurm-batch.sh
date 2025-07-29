#!/bin/bash
#SBATCH --job-name=furn_nodes
#SBATCH --account=conf-iccv-2021.03.25-wonkap
#SBATCH --output=slurm/%A_%a.out
#SBATCH --error=slurm/%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:v100:4
#SBATCH --mem=24G
#SBATCH --time=10:00:00
#SBATCH --partition=batch
#SBATCH --qos=conf-iccv-2021.03.25
#SBATCH --array=0-20

conda activate faclab
wandb agent wamreyaz/furniture_nodes_suppl/96njf9mv
