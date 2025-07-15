#!/bin/bash
#FLUX: --job-name=rainbow-plant-2273
#FLUX: -c=24
#FLUX: --queue=amdgpufast
#FLUX: -t=14400
#FLUX: --urgency=16

export NCCL_LL_THRESHOLD='1'

ml spconv/2.1.21-foss-2021a-CUDA-11.3.1
ml PyTorch-Geometric/2.0.2-foss-2021a-CUDA-11.3.1-PyTorch-1.10.0
cd ../..
name=cylinder_asym_networks
export NCCL_LL_THRESHOLD=1
python test_wod.py --config_path 'configs/wod/wod_f3_3_intensity_beam32.yaml' --mode 'test' --save 'True' 2>&1 | tee logs_dir/${name}_logs_wod_32beam_f3_3_intensity_infer_train_v3_2_valeo.txt
