#!/bin/bash
#FLUX: --job-name=RUnet_comb
#FLUX: -c=4
#FLUX: --queue=slurm_shortgpu
#FLUX: -t=2400
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
module load python/3.6.0
module load groupmods/me539/cuda
module list
python3 py_comb.py
