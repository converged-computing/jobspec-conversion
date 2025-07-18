#!/bin/bash
#FLUX: --job-name=artsy
#FLUX: -c=2
#FLUX: --queue=gpu_p
#FLUX: -t=600
#FLUX: --urgency=16

export PATH='/usr/local/cuda-10.1/bin:$PATH'
export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/usr/local/cuda-10.1/lib64'
export TFHUB_CACHE_DIR='./tmp'

source ~/.bashrc
export PATH=/usr/local/cuda-10.1/bin:$PATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-10.1/lib64
export TFHUB_CACHE_DIR=./tmp
conda activate artsyml
python video_stream_benchmark_parallel.py
