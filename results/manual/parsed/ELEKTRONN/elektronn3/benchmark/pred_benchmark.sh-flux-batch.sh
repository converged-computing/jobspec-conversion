#!/bin/bash
#FLUX: --job-name=lovable-poo-2071
#FLUX: -c=4
#FLUX: -t=1800
#FLUX: --priority=16

export CUDA_VISIBLE_DEVICES='0'

module purge
module load anaconda/3/2020.02
conda activate e3
export CUDA_VISIBLE_DEVICES=0
srun python3 ./pred_benchmark.py
