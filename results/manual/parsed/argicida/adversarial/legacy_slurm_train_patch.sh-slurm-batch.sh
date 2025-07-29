#!/bin/bash
#SBATCH --job-name=blackbox_test
#SBATCH --account=blackbox
#SBATCH --output=blackbox.out
#SBATCH --error=blackbox.err
#SBATCH --mail-user=xxd9704@rit.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:1
#SBATCH --mem-per-cpu=65536
#SBATCH --time=5-00:00:00
#SBATCH --partition=tier3

source ./venv/bin/activate
python train_patch.py paper_obj
deactivate
