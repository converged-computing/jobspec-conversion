#!/bin/bash
#FLUX: --job-name=Lotus
#FLUX: --queue=batch
#FLUX: -t=216000
#FLUX: --urgency=16

module load openmpi/3.0.0/gcc-6.4.0
module load gcc/6.4.0
module load python/2.7.14
module load boost/1.76.0
source ~/.profile
./Allrun -parallel 1
