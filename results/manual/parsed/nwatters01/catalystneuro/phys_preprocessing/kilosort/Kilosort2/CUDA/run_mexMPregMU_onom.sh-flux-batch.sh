#!/bin/bash
#FLUX: --job-name=confused-nalgas-5083
#FLUX: --queue=jazayeri
#FLUX: -t=14400
#FLUX: --urgency=16

export MW_NVCC_PATH='/cm/shared/openmind/cuda/9.1/bin'

module add openmind/cuda/9.1
export MW_NVCC_PATH=/cm/shared/openmind/cuda/9.1/bin
module add mit/matlab/2018b
matlab -nodisplay -r "mexGPUall"
