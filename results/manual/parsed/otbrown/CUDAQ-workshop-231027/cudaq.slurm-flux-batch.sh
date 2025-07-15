#!/bin/bash
#FLUX: --job-name=goodbye-frito-3222
#FLUX: --queue=gpu
#FLUX: -t=120
#FLUX: --priority=16

source /work/tc053/tc053/shared/CUDAQ-workshop-231027/environment.sh
source $CUDAQ_DIR/modules.sh
nvq++ -O3 -o qft-nv64 --target nvidia-fp64 $CUDAQ_DIR/examples/qft.cpp
srun ./qft-nv64
