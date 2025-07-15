#!/bin/bash
#FLUX: --job-name="is2re-gemnet"
#FLUX: -t=28800
#FLUX: --priority=16

export PATH='/usr/local/bin:$PATH'
export LD_LIBRARY_PATH='/usr/local/cuda-11.1/lib64:/usr/local/extras/CUPTI/lib64:/usr/local/lib:$LD_LIBRARY_PATH'
export CUDADIR='/usr/local/cuda-11.1'
export CUDA_HOME='/usr/local/cuda-11.1'
export NCCL_P2P_LEVEL='PIX'

conda activate ocp-models
export PATH=/usr/local/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-11.1/lib64:/usr/local/extras/CUPTI/lib64:/usr/local/lib:$LD_LIBRARY_PATH
export CUDADIR=/usr/local/cuda-11.1
export CUDA_HOME=/usr/local/cuda-11.1
export NCCL_P2P_LEVEL=PIX
srun python -u -m torch.distributed.launch --nproc_per_node=8 main.py \
  --distributed --num-gpus 8 --mode train --config-yml configs/is2re/100k/gemnet/gemnet-dT.yml \
  --deepspeed-config configs/is2re/100k/gemnet/ds_config.json
