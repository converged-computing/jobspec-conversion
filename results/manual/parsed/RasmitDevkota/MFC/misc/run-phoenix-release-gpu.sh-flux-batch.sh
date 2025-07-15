#!/bin/bash
#FLUX: --job-name=gassy-pedo-3511
#FLUX: --urgency=16

cd "$SLURM_SUBMIT_DIR"
echo "Running in $(pwd):"
set -x
. ./mfc.sh load -c p -m GPU
gpu_count=$(nvidia-smi -L | wc -l)        # number of GPUs on node
gpu_ids=$(seq -s ' ' 0 $(($gpu_count-1))) # 0,1,2,...,gpu_count-1
./mfc.sh test -a -b mpirun -j $(nproc) \
              --gpu -g $gpu_ids
