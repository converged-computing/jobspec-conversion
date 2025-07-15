#!/bin/bash
#FLUX: --job-name=anxious-carrot-1381
#FLUX: -t=1800
#FLUX: --urgency=16

export PSM2_MULTI_EP='1 # prevents conflict with MPI using PSM2'
export FI_PSM2_DISCONNECT='1 # enables reconnection'

set -eu
export PSM2_MULTI_EP=1 # prevents conflict with MPI using PSM2
export FI_PSM2_DISCONNECT=1 # enables reconnection
echo "Activating env"
. $HOME/spack/share/spack/setup-env.sh
module load gcc/8.2.0-g7hppkz
spack env activate myenv
echo "Starting application"
srun -N 2 -n 4 ...
