#!/bin/bash
#FLUX: --job-name=hpml
#FLUX: -c=8
#FLUX: -t=10800
#FLUX: --urgency=16

module purge
module load anaconda3/2020.07
eval "$(conda shell.bash hook)"
conda activate assignment
/scratch/pp2603/envs_dirs/assignment/bin/python main.py --workers=4 --batchsize=128 --cuda --optimizer="SGD"
