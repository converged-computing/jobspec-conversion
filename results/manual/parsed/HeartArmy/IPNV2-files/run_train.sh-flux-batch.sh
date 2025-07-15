#!/bin/bash
#FLUX: --job-name=doopy-eagle-7849
#FLUX: --urgency=16

source ~/.bashrc
conda activate /scratch/maj596/conda-envs/IPNV2_pytorch
python IPN\ V2_train.py
