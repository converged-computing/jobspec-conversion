#!/bin/bash
#FLUX: --job-name=stemgen
#FLUX: --priority=16

module load python/3.10 cuda/11.7 sox
source env/bin/activate
python train_model.py
