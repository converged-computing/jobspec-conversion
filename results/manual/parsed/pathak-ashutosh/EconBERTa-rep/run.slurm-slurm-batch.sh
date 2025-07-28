#!/bin/bash
#FLUX: --job-name=python-gpu
#FLUX: --queue=gpuq
#FLUX: -t=14400
#FLUX: --urgency=16

export PYTHONPATH='$(pwd):$PYTHONPATH'

set -x
umask 0027
cd /scratch/apathak2/Project
export PYTHONPATH=$(pwd):$PYTHONPATH
nvidia-smi
module load gnu10                           
module load python
python src/main.py
