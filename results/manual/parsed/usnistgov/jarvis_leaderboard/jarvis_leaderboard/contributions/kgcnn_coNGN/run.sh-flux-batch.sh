#!/bin/bash
#FLUX: --job-name=coNGN
#FLUX: -n=16
#FLUX: --queue=gpu_4
#FLUX: -t=172800
#FLUX: --urgency=16

export LD_LIBRARY_PATH='/opt/bwhpc/common/devel/cuda/11.8/extras/CUPTI/lib64/:$LD_LIBRARY_PATH'
export XLA_FLAGS='--xla_gpu_cuda_data_dir=/opt/bwhpc/common/devel/cuda/11.8/'

ulimit -s unlimited
eval "$(conda shell.bash hook)"
echo $CONDA_PREFIX
conda activate leaderboard
echo $CONDA_PREFIX
module load devel/cuda/11.8
export LD_LIBRARY_PATH=/opt/bwhpc/common/devel/cuda/11.8/extras/CUPTI/lib64/:$LD_LIBRARY_PATH
export XLA_FLAGS=--xla_gpu_cuda_data_dir=/opt/bwhpc/common/devel/cuda/11.8/
nvidia-smi
echo $LD_LIBRARY_PATH
python3 run.py
