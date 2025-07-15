#!/bin/bash
#FLUX: --job-name=adorable-staircase-0822
#FLUX: --queue=gpu_4,gpu_8
#FLUX: -t=172800
#FLUX: --priority=16

echo "$0" "$@"
module load compiler/gnu/10.2
module load mpi/openmpi
eval "$(conda shell.bash hook)"
conda activate onlypybin
env
nvidia-smi
echo q | htop -C  | tail -c +10
set -eu
numsimul="$1"
shift
./run-simul.sh "$numsimul" 1 "$@"
