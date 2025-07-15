#!/bin/bash
#FLUX: --job-name=TensorLNN
#FLUX: --priority=16

source activate pytorch-env
srun python wsd_main.py
