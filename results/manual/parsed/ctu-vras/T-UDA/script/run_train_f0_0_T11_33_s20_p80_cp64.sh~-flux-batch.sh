#!/bin/bash
#FLUX: --job-name=red-plant-3319
#FLUX: --queue=amdgpu
#FLUX: -t=86400
#FLUX: --urgency=16

cd ..
ml torchsparse/1.4.0-foss-2021a-CUDA-11.3.1
python train.py configs/semantic_kitti/spvcnn/cr0p64.yaml --distributed False --ssl True
