#!/bin/bash
#SBATCH --job-name=Muframex
#SBATCH --output=results.log
#SBATCH --mail-user=giovanni.lopez@cimat.mx
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=GPU

nvidia-smi
cd $(pwd)
source /opt/anaconda3_titan/bin/activate
conda activate torch
hostname
python src/test.py
date
