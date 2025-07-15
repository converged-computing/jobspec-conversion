#!/bin/bash
#FLUX: --job-name=stinky-lamp-0616
#FLUX: -t=36000
#FLUX: --priority=16

[ ! -d "slurm_logs" ] && echo "Create a directory slurm_logs" && mkdir -p slurm_logs
module load cuda/11.1.1
module load gcc
echo "===> Anaconda env loaded"
source ~/.bashrc
source activate openpoints
nvidia-smi
nvcc --version
hostname
NUM_GPU_AVAILABLE=`nvidia-smi --query-gpu=name --format=csv,noheader | wc -l`
echo $NUM_GPU_AVAILABLE
cfg=$1
PY_ARGS=${@:2}
python examples/segmentation/main.py --cfg $cfg ${PY_ARGS}
