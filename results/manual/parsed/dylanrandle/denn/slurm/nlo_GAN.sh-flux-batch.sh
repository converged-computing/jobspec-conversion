#!/bin/bash
#FLUX: --job-name=nlo_gan
#FLUX: -n=48
#FLUX: --queue=test
#FLUX: -t=360
#FLUX: --urgency=16

module load gcc/10.2.0-fasrc01
module load Anaconda3/2020.11
source activate denn
cd ../denn
echo "y" | python experiments.py --gan --pkey nlo
