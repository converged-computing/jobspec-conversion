#!/bin/bash
#FLUX: --job-name=TensorLNN
#FLUX: --urgency=16

source activate pytorch-env
srun python wsd_main.py
