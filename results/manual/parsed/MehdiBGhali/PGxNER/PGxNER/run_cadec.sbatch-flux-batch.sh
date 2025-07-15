#!/bin/bash
#FLUX: --job-name=CADEC_train
#FLUX: --queue=gpu_prod_long
#FLUX: -t=43200
#FLUX: --priority=16

export PATH='/opt/conda/bin:$PATH'

echo "Running on $(hostname)"
export PATH=/opt/conda/bin:$PATH
conda info --envs
source activate new_PGx_env
python3 -m pip install torch torch
python ./BARTNER/train.py --dataset_name CADEC
