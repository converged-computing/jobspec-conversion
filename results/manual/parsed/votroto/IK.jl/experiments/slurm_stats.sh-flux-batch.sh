#!/bin/bash
#FLUX --job-name=red-omelette-1742
#FLUX -n=13
#FLUX -c=4
#FLUX --queue=cpu
#FLUX -t=86340
#FLUX --urgency=16

module load Gurobi
module load Julia
srun -l --multi-prog ./experiments/slurm_stats.conf
