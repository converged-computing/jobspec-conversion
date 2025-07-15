#!/bin/bash
#FLUX: --job-name=chocolate-lettuce-8819
#FLUX: -c=10
#FLUX: -t=28800
#FLUX: --urgency=16

echo "SLURM_NODELIST $SLURM_NODELIST"
echo "NUMBER OF CORES $SLURM_NTASKS"
nvidia-smi
python -u run_train.py
