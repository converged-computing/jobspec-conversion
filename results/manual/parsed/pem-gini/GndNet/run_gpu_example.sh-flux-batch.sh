#!/bin/bash
#FLUX: --job-name=butterscotch-bike-8609
#FLUX: --urgency=16

module load CUDA
echo; export; echo; nvidia-smi; echo
$CUDA_ROOT/extras/demo_suite/deviceQuery -noprompt
