#!/bin/bash
#FLUX: --job-name=transport
#FLUX: -n=30
#FLUX: -t=145800
#FLUX: --urgency=16

source ~/anaconda3/etc/profile.d/conda.sh
conda activate fenics2018							   
time mpirun python adv-diff-Dif2-CN.py > log.out
