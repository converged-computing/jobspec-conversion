#!/bin/bash
#FLUX: --job-name=expressive-blackbean-8903
#FLUX: -c=4
#FLUX: -t=86400
#FLUX: --urgency=16

export CUDA_VISIBLE_DEVICES='0'

module load python/3.8
source /home/mila/c/chris.emezue/scratch/py38env/bin/activate
export CUDA_VISIBLE_DEVICES=0
python3 get_all_orientations_dag.py
