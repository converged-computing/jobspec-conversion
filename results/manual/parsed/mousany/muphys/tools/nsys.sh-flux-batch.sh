#!/bin/bash
#FLUX: --job-name=scc
#FLUX: --exclusive
#FLUX: --queue=gpu
#FLUX: -t=600
#FLUX: --urgency=16

export LD_LIBRARY_PATH='/sw/spack-levante/nvhpc-23.7-xasprs/Linux_x86_64/23.7/profilers/Nsight_Systems/host-linux-x64/:/sw/spack-levante/nvhpc-23.7-xasprs/Linux_x86_64/23.7/cuda/lib64'

ulimit -s unlimited
ulimit -c 0
. scripts/levante-setup.sh nvidia gpu
export LD_LIBRARY_PATH=/sw/spack-levante/nvhpc-23.7-xasprs/Linux_x86_64/23.7/profilers/Nsight_Systems/host-linux-x64/:/sw/spack-levante/nvhpc-23.7-xasprs/Linux_x86_64/23.7/cuda/lib64
nsys profile -w true -t cuda -o nsight_report -f true -x true build/bin/graupel $1
