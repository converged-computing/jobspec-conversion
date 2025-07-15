#!/bin/bash
#FLUX: --job-name=hanky-dog-7508
#FLUX: -c=10
#FLUX: --gpus-per-task=1
#FLUX: -t=14400
#FLUX: --priority=16

conda activate tfp
srun python scripts/train_ae.py
srun python scripts/train_flow.py 
srun python scripts/run_posterior_analysis.py
