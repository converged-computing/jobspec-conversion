#!/bin/bash
#FLUX: --job-name=nlp_vqa
#FLUX: -n=2
#FLUX: -c=4
#FLUX: -t=28800
#FLUX: --urgency=16

module load gcc/8.2.0 python_gpu/3.10.4 cuda/11.8.0 git-lfs/2.3.0 git/2.31.1 eth_proxy
source "${SCRATCH}/.python_venv/vqa/bin/activate"
python torch_dataset.py
