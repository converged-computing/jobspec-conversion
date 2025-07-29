#!/bin/bash
#SBATCH --output=logs/%j.%x.%N.out
#SBATCH --error=logs/%j.%x.%N.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=gpu:8
#SBATCH --time=5-00:00:00

python search_spaces/hat/train.py --configs=search_spaces/hat/configs/wmt14.en-fr/supertransformer/space0.yml
