#!/bin/bash
#FLUX: --job-name=eccentric-underoos-1582
#FLUX: -c=24
#FLUX: --queue=amdgpufast
#FLUX: -t=14400
#FLUX: --urgency=16

export NCCL_LL_THRESHOLD='0'

ml spconv/2.1.21-foss-2021a-CUDA-11.3.1
ml PyTorch-Geometric/2.0.2-foss-2021a-CUDA-11.3.1-PyTorch-1.10.0
cd ../..
name=t-uda
export NCCL_LL_THRESHOLD=0
echo "epoch 0"
python test.py --config_path 'configs/data_config/da_kitti_poss/uda_poss_kitti_f2_0_time.yaml'  --mode 'val'  --save 'True' 2>&1 | tee logs_dir/${name}_uda_val_poss_f2_2_time.txt
