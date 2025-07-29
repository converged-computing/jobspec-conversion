#!/bin/bash
#SBATCH --account=def-jhoey
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=32G
#SBATCH --time=00:10:00

nvidia-smi
SOURCEDIR=/scratch/aarti9
pip install --no-index --upgrade pip
pip install --no-index -r requirements.txt
python $SOURCEDIR/vgaf_PP_Val_16F.py
