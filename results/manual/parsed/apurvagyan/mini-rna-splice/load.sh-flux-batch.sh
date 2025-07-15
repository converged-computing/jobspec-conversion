#!/bin/bash
#FLUX: --job-name=load_graphs_batch
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=7200
#FLUX: --priority=16

module load miniconda
conda activate env_3_8
python load_batch.py
