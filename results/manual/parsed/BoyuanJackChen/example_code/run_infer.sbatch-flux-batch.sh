#!/bin/bash
#FLUX: --job-name=run_infer
#FLUX: --queue=nvidia
#FLUX: -t=7199
#FLUX: --urgency=16

export TRANSFORMERS_CACHE='/scratch/[your NetID]/huggingface_cache'

module purge
source ~/.bashrc
conda activate [your conda env]
export TRANSFORMERS_CACHE="/scratch/[your NetID]/huggingface_cache"
python -u infer_codegen.py
