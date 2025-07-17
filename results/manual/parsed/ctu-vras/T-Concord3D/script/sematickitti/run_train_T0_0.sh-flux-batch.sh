#!/bin/bash
#FLUX: --job-name=boopy-underoos-3919
#FLUX: -c=6
#FLUX: --queue=amdgpulong
#FLUX: -t=259200
#FLUX: --urgency=16

ml spconv/2.1.21-foss-2021a-CUDA-11.3.1
ml PyTorch-Geometric/2.0.2-foss-2021a-CUDA-11.3.1-PyTorch-1.10.0
cd ../..
name=T-Concord3D
python train_tconcord3d.py --config_path 'config/semantickitti/semantickitti_T0_0.yaml' \
2>&1 | tee logs_dir/${name}_logs_tee_T0_0.txt
