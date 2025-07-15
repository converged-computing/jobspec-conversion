#!/bin/bash
#FLUX: --job-name=fold2array
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=43200
#FLUX: --priority=16

module load miniconda
conda activate env_3_8
python fold2array_batch.py
