#!/bin/bash
#FLUX: --job-name=expressive-latke-3468
#FLUX: --gpus-per-task=4
#FLUX: --queue=gpu
#FLUX: -t=7200
#FLUX: --urgency=16

echo "===================================="
echo "ARGS       = $@"
echo "===================================="
echo Running on host $USER@$HOSTNAME
echo Node: $(hostname)
echo Start: $(date +%F-%R:%S)
echo -e Working dir: $(pwd)
echo Dynamic shared libraries: $LD_LIBRARY_PATH
source credentials.txt
echo "====== starting experiment ========="
CUDA_VISIBLE_DEVICES=0,1,2,3 python -m vllm.entrypoints.api_server --model mistralai/Mixtral-8x7B-v0.1 --port 8002 --tensor-parallel-size 4 --download-dir /project/scratch/p200149/vllm
