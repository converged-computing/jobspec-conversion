#!/bin/bash
#FLUX: --job-name=dirty-pancake-7657
#FLUX: -t=300
#FLUX: --priority=16

module purge
module load gcc/11.3.0 cmake/3.26.3 openmpi/4.1.5
srun ../build/quicksort-gpu
