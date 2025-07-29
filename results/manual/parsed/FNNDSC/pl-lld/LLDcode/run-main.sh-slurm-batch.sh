#!/bin/bash
#SBATCH --job-name=main
#SBATCH --output=main-output_%j.txt
#SBATCH --mail-user=andy.tsai@childrens.harvard.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:Tesla_T:3
#SBATCH --mem-per-cpu=20GB
#SBATCH --time=1-06:00:00

source /programs/biogrids.shrc
python.tensorflow main.py
