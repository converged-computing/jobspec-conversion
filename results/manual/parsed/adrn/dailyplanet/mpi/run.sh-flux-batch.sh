#!/bin/bash
#FLUX: --job-name=gassy-hobbit-7991
#FLUX: --urgency=16

cd /tigress/adrianp/projects/dailyplanet/scripts/
module load openmpi/gcc/1.10.2/64
source activate twoface
date
srun python run_planetz.py -v -c ../config/planetz.yml --mpi --data-path=../data/keck_vels/ --ext=vels
date
