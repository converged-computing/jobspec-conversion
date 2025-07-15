#!/bin/bash
#FLUX: --job-name=buttery-latke-2248
#FLUX: -n=8
#FLUX: --queue=cpu
#FLUX: -t=21600
#FLUX: --urgency=16

module purge
module load GCC/11.2.0 
module list
CLUSTER=vega_ucxonly make info
CLUSTER=vega_ucxonly make install
