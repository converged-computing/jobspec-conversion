#!/bin/bash
#FLUX: --job-name=warpx
#FLUX: -c=8
#FLUX: --gpus-per-task=1
#FLUX: --queue=batch
#FLUX: -t=600
#FLUX: --urgency=16

export FI_MR_CACHE_MONITOR='memhooks  # alternative cache monitor'
export ROCFFT_RTC_CACHE_PATH='/dev/null'
export OMP_NUM_THREADS='8'

export FI_MR_CACHE_MONITOR=memhooks  # alternative cache monitor
export ROCFFT_RTC_CACHE_PATH=/dev/null
export OMP_NUM_THREADS=8
srun ./warpx inputs > output.txt
