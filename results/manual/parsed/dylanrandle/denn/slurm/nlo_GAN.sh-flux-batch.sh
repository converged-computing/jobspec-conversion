#!/bin/bash
#FLUX: --job-name=spicy-snack-1153
#FLUX: --priority=16

module load gcc/10.2.0-fasrc01
module load Anaconda3/2020.11
source activate denn
cd ../denn
echo "y" | python experiments.py --gan --pkey nlo
