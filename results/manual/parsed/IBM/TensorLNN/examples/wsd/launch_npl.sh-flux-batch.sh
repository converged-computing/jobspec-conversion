#!/bin/bash
#FLUX: --job-name=TensorLNN
#FLUX: -n=2
#FLUX: --queue=npl
#FLUX: -t=600
#FLUX: --urgency=16

source activate pytorch-env
srun python wsd_main.py
