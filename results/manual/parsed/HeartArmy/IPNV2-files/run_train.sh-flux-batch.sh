#!/bin/bash
#FLUX --job-name=moolicious-puppy-9269
#FLUX -n=10
#FLUX --queue=nvidia
#FLUX -t=172800
#FLUX --urgency=16

source ~/.bashrc
conda activate /scratch/maj596/conda-envs/IPNV2_pytorch
python IPN\ V2_train.py
