#!/bin/bash
#SBATCH --job-name=doors
#SBATCH --account=conf-gpu-2020.11.23
#SBATCH --output=slurm/%A-%a.out
#SBATCH --error=slurm/%A-%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:v100
#SBATCH --mem=24G
#SBATCH --time=06:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=0-30

conda activate faclab
which conda
which python
wandb agent wamreyaz/Triplesxy/32q6vpqn
wandb agent wamreyaz/Triples_hw/aqhkplbr
