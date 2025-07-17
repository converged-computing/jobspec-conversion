#!/bin/bash
#FLUX: --job-name=gpu_serial
#FLUX: --queue=devel
#FLUX: --urgency=16

module load CUDA
echo; export; echo; nvidia-smi; echo
$CUDA_ROOT/extras/demo_suite/deviceQuery -noprompt
