#!/bin/bash
#SBATCH --job-name=preds
#SBATCH --output=/home/%u/output/sb_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=0
#SBATCH --time=02:00:00

source activate tiny_torch
python torchlightning_predict.py -DT 2021-08-12-21-31 -t 2 -lat 32.62 -lon -83.27 -hs 255 -c C13 -f
