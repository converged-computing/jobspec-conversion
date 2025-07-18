#!/bin/bash
#FLUX: --job-name=gpt
#FLUX: -N=32
#FLUX: --exclusive
#FLUX: -t=1800
#FLUX: --urgency=16

MODEL=forge-mat
source neox-env.sh 
echo "PATH=$PATH" > .deepspeed_env
echo "LD_LIBRARY_PATH=$LD_LIBRARY_PATH" >> .deepspeed_env
echo "CPATH=$CPATH" >> .deepspeed_env
echo "CUDAPATH=${ROCM_PATH}" >> .deepspeed_env
echo "TORCH_EXTENSIONS_DIR=$(pwd)/deepspeed" >> .deepspeed_env
echo "NCCL_DEBUG=INFO" >> .deepspeed_env
echo "FI_CXI_ATS=0" >> .deepspeed_env
echo "NCCL_SOCKET_IFNAME=hsn" >> .deepspeed_env
python -u ./deepy.py train.py -d configs ${MODEL}.yml frontier.yml
