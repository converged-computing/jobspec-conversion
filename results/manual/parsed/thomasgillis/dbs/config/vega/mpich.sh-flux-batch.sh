#!/bin/bash
#FLUX: --job-name=grated-banana-8849
#FLUX: -n=8
#FLUX: --queue=cpu
#FLUX: -t=21600
#FLUX: --urgency=16

echo "loading modules"
module load GCC/10.3.0
module load Automake/1.16.3-GCCcore-10.3.0
module load Autoconf/2.71-GCCcore-10.3.0
module load libtool/2.4.6-GCCcore-10.3.0
module load CMake/3.20.1-GCCcore-10.3.0
module list
CLUSTER=vega_mpich make info
CLUSTER=vega_mpich make install
