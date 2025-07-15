#!/bin/bash
#FLUX: --job-name=Inference
#FLUX: --queue=gpu_prod_long
#FLUX: -t=43200
#FLUX: --priority=16

export PATH='/opt/conda/bin:$PATH'

echo "Running on $(hostname)"
export PATH=/opt/conda/bin:$PATH
conda info --envs
source activate final_PGx_env
python ./BARTNER_adapted/predictor.py
