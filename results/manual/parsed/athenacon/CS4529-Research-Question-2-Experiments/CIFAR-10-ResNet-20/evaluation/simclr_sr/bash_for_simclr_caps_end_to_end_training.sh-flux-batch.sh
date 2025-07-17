#!/bin/bash
#FLUX: --job-name=crusty-house-4023
#FLUX: -c=6
#FLUX: --queue=gpu
#FLUX: -t=540000
#FLUX: --urgency=16

nvidia-smi
conda init
module load miniconda3
conda activate testenv
which python
python --version
srun /home/u16ak20/.conda/envs/testenv/bin/python linear_evaluation.py
