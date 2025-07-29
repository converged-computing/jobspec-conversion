#!/bin/bash
#SBATCH --job-name=MPI_JOB
#SBATCH --output=output.%J.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:volta:2
#SBATCH --mem=6G
#SBATCH --time=1-00:00:00

source /home/mr634151/miniconda3/bin/activate
conda activate pytorch4sam
python UnetPlusSamPredictor.py
