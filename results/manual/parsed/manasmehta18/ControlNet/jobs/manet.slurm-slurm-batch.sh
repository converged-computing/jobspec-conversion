#!/bin/bash
#SBATCH --job-name=manet-run
#SBATCH --output=/ocean/projects/iri180005p/mmehta1/ControlNet/logs/manet.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=v100-32:1
#SBATCH --time=1-23:59:00
#SBATCH --partition=GPU-shared

set -x
cd /ocean/projects/iri180005p/mmehta1/ControlNet
pwd
conda deactivate
module load anaconda3/2020.11
conda activate control
nvidia-smi
python train_manet.py
