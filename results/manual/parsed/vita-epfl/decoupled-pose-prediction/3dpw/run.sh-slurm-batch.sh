#!/bin/bash
#SBATCH --account=vita
#SBATCH --output=jta_long
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --gres=gpu:1
#SBATCH --mem=10G
#SBATCH --time=03:00:00

module load gcc python py-torchvision py-torch
source ../../venv*/bin/activate
echo STARTING AT `date`
python test.py
echo FINISHED at `date`
