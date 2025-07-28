#!/bin/bash
#FLUX: --job-name=CS 601.471/671 homework6 3.1.2
#FLUX: -N=2
#FLUX: --queue=mig_class
#FLUX: -t=7200
#FLUX: --urgency=16

module load anaconda 
source ~/.bashrc
conda activate ssm_hw6 # activate the Python environment
python base_classification.py --device cuda --model "distilbert-base-uncased" --batch_size "32" --lr 1e-4 --num_epochs 30
