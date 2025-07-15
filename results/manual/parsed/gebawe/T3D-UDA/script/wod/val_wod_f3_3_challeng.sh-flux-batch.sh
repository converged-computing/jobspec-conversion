#!/bin/bash
#FLUX: --job-name=creamy-egg-0534
#FLUX: --queue=amdgpufast
#FLUX: -t=14400
#FLUX: --urgency=16

export NCCL_LL_THRESHOLD='0'

ml spconv/2.1.21-foss-2021a-CUDA-11.3.1
ml PyTorch-Geometric/2.0.2-foss-2021a-CUDA-11.3.1-PyTorch-1.10.0
cd ../..
name=cylinder_asym_networks
export NCCL_LL_THRESHOLD=0
CUDA_VISIBLE_DEVICES=0,1,2 NCCL_P2P_DISABLE=1 python -u -m torch.distributed.launch --nproc_per_node=3 --master_port=$RANDOM test_cylinder_asym_wod.py --config_path 'configs/wod/wod_f3_3.yaml' --mode 'val' --challenge 'True' --save 'True' 2>&1 | tee logs_dir/${name}_logs_val_f3_3_b3_v3_2.txt
