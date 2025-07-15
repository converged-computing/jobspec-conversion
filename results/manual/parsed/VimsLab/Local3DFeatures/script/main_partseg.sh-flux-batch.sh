#!/bin/bash
#FLUX: --job-name=goodbye-lizard-6021
#FLUX: -t=86400
#FLUX: --urgency=16

[ ! -d "slurm_logs" ] && echo "Create a directory slurm_logs" && mkdir -p slurm_logs
module load cuda/11.1.1
module load gcc
echo "===> Anaconda env loaded"
source activate openpoints
while true
do
    PORT=$(( ((RANDOM<<15)|RANDOM) % 49152 + 10000 ))
    status="$(nc -z 127.0.0.1 $PORT < /dev/null &>/dev/null; echo $?)"
    if [ "${status}" != "0" ]; then
        break;
    fi
done
echo $PORT
nvidia-smi
nvcc --version
hostname
NUM_GPU_AVAILABLE=`nvidia-smi --query-gpu=name --format=csv,noheader | wc -l`
echo $NUM_GPU_AVAILABLE
cfg=$1
PY_ARGS=${@:2}
python examples/shapenetpart/main.py --cfg $cfg ${PY_ARGS}
