#!/bin/bash
#FLUX: --job-name="joint_11"
#FLUX: --queue=gpu-shared
#FLUX: --priority=16

export CUDA_HOME='/usr/local/cuda-8.0'
export LD_LIBRARY_PATH='/home/enijkamp/cudnn-3.0/lib64:$LD_LIBRARY_PATH'
export PATH='${CUDA_HOME}/bin:${PATH}'
export LD_PRELOAD='$LD_PRELOAD:/usr/lib64/libstdc++.so.6:/usr/local/cuda-8.0/lib64/libcudart.so.8.0:/usr/local/cuda-8.0/lib64/libcublas.so.8.0:/usr/local/cuda-8.0/lib64/libcufft.so.8.0'
export CPATH='/home/enijkamp/cudnn-3.0/include/'
export LIBRARY_PATH='/home/enijkamp/cudnn-3.0/lib64:$LIBRARY_PATH'

export CUDA_HOME=/usr/local/cuda-8.0
export LD_LIBRARY_PATH=${CUDA_HOME}/lib64:$LD_LIBRARY_PATH
export PATH=${CUDA_HOME}/bin:${PATH}
export LD_PRELOAD=$LD_PRELOAD:/usr/lib64/libstdc++.so.6:/usr/local/cuda-8.0/lib64/libcudart.so.8.0:/usr/local/cuda-8.0/lib64/libcublas.so.8.0:/usr/local/cuda-8.0/lib64/libcufft.so.8.0
export CPATH=/home/enijkamp/cudnn-3.0/include/
export LD_LIBRARY_PATH=/home/enijkamp/cudnn-3.0/lib64:$LD_LIBRARY_PATH
export LIBRARY_PATH=/home/enijkamp/cudnn-3.0/lib64:$LIBRARY_PATH
module load matlab
matlab -nodisplay -nosplash -nojvm -r "exp_texture_joint_11()"
