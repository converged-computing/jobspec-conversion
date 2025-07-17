#!/bin/bash
#FLUX: --job-name=angry-poodle-4106
#FLUX: -c=6
#FLUX: --queue=amdgpufast
#FLUX: -t=14400
#FLUX: --urgency=16

ml spconv/2.1.21-foss-2021a-CUDA-11.3.1
ml PyTorch-Geometric/2.0.2-foss-2021a-CUDA-11.3.1-PyTorch-1.10.0
cd ../..
name=T-concord3D
python test.py --config_path 'config/semantickitti/semantickitti_T3_3_s20.yaml' \
--mode 'infer' --save 'True' 2>&1 | tee logs_dir/${name}_logs_test_T3_3_s20.txt
