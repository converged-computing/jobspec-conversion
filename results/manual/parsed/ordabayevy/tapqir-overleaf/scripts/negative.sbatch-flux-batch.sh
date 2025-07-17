#!/bin/bash
#FLUX: --job-name=negative
#FLUX: --urgency=16

lamdas=(0.01 0.05 0.15 0.5 1)
python scripts/cosmos_simulations.py \
  --gain 7 --pi 0 --height 3000 --proximity 0.2 \
  --lamda ${lamdas[${SLURM_ARRAY_TASK_ID}]} \
  --cuda \
  --path simulations/negative${lamdas[${SLURM_ARRAY_TASK_ID}]}
