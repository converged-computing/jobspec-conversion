#!/bin/bash
#FLUX: --job-name=mcmc_runner
#FLUX: --priority=16

module load Python
./venv/bin/python plot_maps_helper.py --states $1 --start $SLURM_ARRAY_TASK_ID
