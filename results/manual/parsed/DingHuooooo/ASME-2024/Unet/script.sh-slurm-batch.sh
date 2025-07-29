#!/bin/bash
#SBATCH --job-name=MPI_JOB
#SBATCH --output=output.%J.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:volta:2
#SBATCH --mem=6G
#SBATCH --time=10:00:00

source /home/ai773056/anaconda3/bin/activate
conda activate pytorch4sam
python UnetPredictor.py
