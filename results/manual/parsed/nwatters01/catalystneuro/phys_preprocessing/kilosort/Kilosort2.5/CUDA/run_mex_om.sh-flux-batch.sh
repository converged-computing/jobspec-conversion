#!/bin/bash
#FLUX: --job-name=muffled-blackbean-5895
#FLUX: --queue=jazayeri
#FLUX: -t=14400
#FLUX: --priority=16

export MW_NVCC_PATH='/cm/shared/openmind/cuda/9.1/bin'

module add openmind/cuda/9.1
export MW_NVCC_PATH=/cm/shared/openmind/cuda/9.1/bin
module add mit/matlab/2018b
matlab -nodisplay -r "mexGPUall"
