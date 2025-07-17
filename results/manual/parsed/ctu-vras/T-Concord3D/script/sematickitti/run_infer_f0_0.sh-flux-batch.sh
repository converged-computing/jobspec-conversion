#!/bin/bash
#FLUX: --job-name=arid-milkshake-9716
#FLUX: -c=12
#FLUX: --queue=amdgpufast
#FLUX: -t=14400
#FLUX: --urgency=16

ml spconv/2.1.21-foss-2021a-CUDA-11.3.1
ml PyTorch-Geometric/2.0.2-foss-2021a-CUDA-11.3.1-PyTorch-1.10.0
cd ../..
name=T-Concord3D
python3 test.py --config_path 'config/semantickitti/semantickitti_T0_0.yaml' \
--mode 'infer' --save 'True' 2>&1 | tee logs_dir/${name}_logs_val_f0_0.txt
