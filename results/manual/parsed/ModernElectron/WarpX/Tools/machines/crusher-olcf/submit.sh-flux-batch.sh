#!/bin/bash
#FLUX: --job-name=creamy-car-0815
#FLUX: -c=8
#FLUX: --gpus-per-task=1
#FLUX: --urgency=16

export FI_MR_CACHE_MONITOR='memhooks  # alternative cache monitor'
export ROCFFT_RTC_CACHE_PATH='/dev/null'
export OMP_NUM_THREADS='8'

export FI_MR_CACHE_MONITOR=memhooks  # alternative cache monitor
export ROCFFT_RTC_CACHE_PATH=/dev/null
export OMP_NUM_THREADS=8
srun ./warpx inputs > output.txt
