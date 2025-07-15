#!/bin/bash
#FLUX: --job-name=evasive-latke-0939
#FLUX: -c=10
#FLUX: -t=28800
#FLUX: --priority=16

echo "SLURM_NODELIST $SLURM_NODELIST"
echo "NUMBER OF CORES $SLURM_NTASKS"
nvidia-smi
python -u run_train.py
