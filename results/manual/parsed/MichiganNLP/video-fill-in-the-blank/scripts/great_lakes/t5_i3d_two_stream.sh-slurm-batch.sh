#!/bin/bash
#SBATCH --job-name=two_stream
#SBATCH --account=mihalcea1
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --gres=gpu:1
#SBATCH --mem=50G
#SBATCH --time=05:00:00
#SBATCH --partition=gpu

source scripts/great_lakes/init.source
python -u scripts/run_model.py --use-visual --two-stream --train --gpus 1 --num-workers 4 --batch-size 64 "$*"
