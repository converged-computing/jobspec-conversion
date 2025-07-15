#!/bin/bash
#FLUX: --job-name=train_classifier
#FLUX: -n=2
#FLUX: -c=8
#FLUX: -t=252000
#FLUX: --priority=16

export HOME='/scratch/st-sdena-1/miladyz'

module load gcc/9.4.0 python/3.8.10 py-virtualenv/16.7.6
source /scratch/st-sdena-1/miladyz/env_py3.8.10/bin/activate  
cd $SLURM_SUBMIT_DIR
nvidia-smi
pwd
export HOME="/scratch/st-sdena-1/miladyz"
python train_classifier.py
