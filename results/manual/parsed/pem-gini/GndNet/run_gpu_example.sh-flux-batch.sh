#!/bin/bash
#FLUX: --job-name=delicious-destiny-4897
#FLUX: --priority=16

module load CUDA
echo; export; echo; nvidia-smi; echo
$CUDA_ROOT/extras/demo_suite/deviceQuery -noprompt
