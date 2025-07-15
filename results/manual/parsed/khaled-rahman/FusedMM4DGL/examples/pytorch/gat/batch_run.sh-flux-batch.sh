#!/bin/bash
#FLUX: --job-name=nerdy-animal-5131
#FLUX: --priority=16

module unload gcc
module load gcc
srun -p azad -N 1 -n 1 -c 1 bash run_all.sh
