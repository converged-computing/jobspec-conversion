#!/bin/bash
#FLUX: --job-name=doopy-caramel-3104
#FLUX: --urgency=16

module unload gcc
module load gcc
srun -p azad -N 1 -n 1 -c 1 bash run_all.sh
