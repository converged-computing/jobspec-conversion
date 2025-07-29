#!/bin/bash
#SBATCH --account=p200149
#SBATCH --output=job/%J.out
#SBATCH --error=job/%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gpus-per-task=4
#SBATCH --time=02:00:00
#SBATCH --qos=default

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
