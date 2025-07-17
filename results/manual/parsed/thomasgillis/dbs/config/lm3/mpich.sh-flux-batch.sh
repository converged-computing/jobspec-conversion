#!/bin/bash
#FLUX: --job-name=strawberry-leader-6906
#FLUX: -n=8
#FLUX: --queue=batch
#FLUX: -t=7200
#FLUX: --urgency=16

echo "loading modules"
module purge
module load releases/2021b
module load GCC/11.2.0
module load Automake Autoconf libtool CMake
module list
CLUSTER=lm3/mpich make info
CLUSTER=lm3/mpich make install
