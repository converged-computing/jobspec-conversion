#!/bin/bash
#SBATCH --job-name=pix
#SBATCH --output=output_pix_%j.txt
#SBATCH --error=error_pix_%j.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --mem=10GB
#SBATCH --time=08:00:00
#SBATCH --partition=gpu

source activate new_pix
python main.py --backend tensorflow --dset audio_1000 --nb_epoch 400 64 64
