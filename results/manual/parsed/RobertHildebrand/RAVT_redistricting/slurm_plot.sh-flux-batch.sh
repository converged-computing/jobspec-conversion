#!/bin/bash
#FLUX: --job-name=mcmc_runner
#FLUX: --queue=normal_q
#FLUX: -t=19800
#FLUX: --urgency=16

module load Python
./venv/bin/python plot_maps_helper.py --states $1 --start $SLURM_ARRAY_TASK_ID
