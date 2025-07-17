#!/bin/bash
#FLUX: --job-name=buttery-lemon-0827
#FLUX: --queue=awhite
#FLUX: -t=86400
#FLUX: --urgency=16

module load anaconda3/2020.11
module load cuda/11.0
conda activate prettyB
python /scratch/zyang43/ALP-Design/paper/random_search.py
