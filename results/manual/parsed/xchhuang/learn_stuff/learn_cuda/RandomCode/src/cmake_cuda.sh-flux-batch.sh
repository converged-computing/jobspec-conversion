#!/bin/bash
#FLUX: --job-name=expensive-mango-2744
#FLUX: --queue=gpu20
#FLUX: -t=3600
#FLUX: --urgency=16

export PATH='/usr/lib/cuda-${cuda_version}/bin/:${PATH}'
export LD_LIBRARY_PATH='/usr/lib/cuda-${cuda_version}/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}'
export CUDA_PATH='/usr/lib/cuda-${cuda_version}/'

cuda_version=10.2
export PATH=/usr/lib/cuda-${cuda_version}/bin/:${PATH}
export LD_LIBRARY_PATH=/usr/lib/cuda-${cuda_version}/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
export CUDA_PATH=/usr/lib/cuda-${cuda_version}/
nvcc add.cu -o add_cuda
nvprof ./add_cuda
