#!/bin/bash
#FLUX: --job-name=faux-lizard-6056
#FLUX: -c=24
#FLUX: --queue=amdgpuextralong
#FLUX: -t=1814400
#FLUX: --urgency=16

ml spconv/2.1.21-foss-2021a-CUDA-11.3.1
ml PyTorch-Geometric/2.0.2-foss-2021a-CUDA-11.3.1-PyTorch-1.10.0
cd ../..
name=T-Concord3D
python train.py --config_path 'config/semantickitti/semantickitti_S0_0_T11_33_ssl_s20_p80.yaml' \
 2>&1 | tee logs_dir/${name}_logs_semantickitti_S0_0_T11_33.txt
