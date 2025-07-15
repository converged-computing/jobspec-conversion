#!/bin/bash
#FLUX: --job-name=ornery-rabbit-9155
#FLUX: --priority=16

module load numpy
module load python/2.7.6
module load openmpi/1.6.5/b1
srun python Search.py --model=Number --data=300 --steps=10000
exit
