#!/bin/bash
#FLUX: --job-name=expressive-lizard-3070
#FLUX: --priority=16

module load anaconda3/2020.11
module load cuda/11.0
conda activate prettyB
python /scratch/zyang43/ALP-Design/paper/random_search.py
