#!/bin/bash
#FLUX: --job-name=modelnet
#FLUX: -t=21600
#FLUX: --urgency=16

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
python examples/classification/main.py --cfg $cfg ${PY_ARGS}
