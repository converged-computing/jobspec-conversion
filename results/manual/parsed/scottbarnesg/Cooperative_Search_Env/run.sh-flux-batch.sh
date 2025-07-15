#!/bin/bash
#FLUX: --job-name=outstanding-parsnip-6337
#FLUX: --priority=16

module load anaconda
source activate tensorflow
python run_mapEnv.py
