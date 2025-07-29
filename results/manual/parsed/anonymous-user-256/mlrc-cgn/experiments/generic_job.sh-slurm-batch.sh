#!/bin/bash
#SBATCH --job-name=SampleJob
#SBATCH --output=slurm/output_%A.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --mem=32000M
#SBATCH --time=10:00:00

module purge
module load 2021
module load Anaconda3/2021.05
source deactivate
source activate gcn-gpu
python imagenet_pipeline.py
