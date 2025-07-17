#!/bin/bash
#FLUX: --job-name=array
#FLUX: --queue=kicp
#FLUX: -t=43200
#FLUX: --urgency=16

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
nvidia-smi
cd /home/tcallister/repositories/stochastic-birefringence/code/
conda activate stochastic-birefringence
python run_birefringence_delayedSFR_HLO3.py
