#!/bin/bash
#FLUX: --job-name=soma-lulesh
#FLUX: --queue=medium
#FLUX: -t=3600
#FLUX: --urgency=16

set -eu
echo "Setting up spack and modules"
source ./sourceme.sh
echo "Starting LULESH + SOMA"
cp ../lulesh2.0 .
srun -n 1 -N 1 ./lulesh2.0 -i 50 -p
