#!/bin/bash
#FLUX: --job-name=fuzzy-cattywampus-7782
#FLUX: --queue=amdgpufast
#FLUX: -t=14400
#FLUX: --urgency=16

export NCCL_LL_THRESHOLD='0'

ml spconv/2.1.21-foss-2021a-CUDA-11.3.1
ml PyTorch-Geometric/2.0.2-foss-2021a-CUDA-11.3.1-PyTorch-1.10.0
cd ../..
name=cylinder_asym_networks
export NCCL_LL_THRESHOLD=0
python test.py --config_path 'configs/data_config/da_wod_kitti/uda_wod_kitti_f0_0_intensity.yaml' --mode 'val' --challenge 'False' --save 'True' 2>&1 | tee logs_dir/${name}_logs_val_uda_wod_kitti_f0_0_intensity.txt
