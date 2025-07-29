#!/bin/bash
#SBATCH --job-name=test1
#SBATCH --account=e31408
#SBATCH --output=output1
#SBATCH --mail-user=grahamgrieb2023@u.northwestern.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=24G
#SBATCH --time=06:00:00
#SBATCH --constraint=ntasks-per-node=6

source activate /projects/e31408/users/gmg0603/project/env
python create_predictions_with_top_retrieval.py
