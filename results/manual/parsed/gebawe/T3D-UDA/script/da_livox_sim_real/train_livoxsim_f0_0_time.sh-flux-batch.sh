#!/bin/bash
#FLUX: --job-name=gassy-leg-4106
#FLUX: -c=24
#FLUX: --queue=amdgpulong
#FLUX: -t=259200
#FLUX: --urgency=16

export NCCL_LL_THRESHOLD='0'

ml spconv/2.1.21-foss-2021a-CUDA-11.3.1
ml PyTorch-Geometric/2.0.2-foss-2021a-CUDA-11.3.1-PyTorch-1.10.0
cd ../..
name=t-uda
export NCCL_LL_THRESHOLD=0
echo "epoch 0"
python train.py --config_path 'configs/data_config/da_livoxsim_livoxreal/uda_livoxsim_livoxreal_f0_0_time.yaml' 2>&1 | tee logs_dir/${name}_train_uda_livoxsim_train90_val10_f0_0_time.txt
