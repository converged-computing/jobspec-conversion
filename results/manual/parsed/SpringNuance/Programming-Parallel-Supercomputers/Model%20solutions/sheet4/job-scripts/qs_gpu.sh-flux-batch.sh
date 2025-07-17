#!/bin/bash
#FLUX: --job-name=phat-lamp-8503
#FLUX: --queue=courses-gpu
#FLUX: -t=300
#FLUX: --urgency=16

module purge
module load gcc/11.3.0 cmake/3.26.3 openmpi/4.1.5
srun ../build/quicksort-gpu
