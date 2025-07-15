#!/bin/bash
#FLUX: --job-name=height
#FLUX: --urgency=16

heights=(300 500 600 750 1000 1500 2000 3000)
python scripts/cosmos_simulations.py \
  --gain 7 --pi 0.15 --lamda 0.15 --proximity 0.2 \
  --height ${heights[${SLURM_ARRAY_TASK_ID}]} \
  --cuda \
  --path simulations/height${heights[${SLURM_ARRAY_TASK_ID}]}
