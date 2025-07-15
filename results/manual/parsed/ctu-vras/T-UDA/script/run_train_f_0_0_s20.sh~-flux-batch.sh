#!/bin/bash
#FLUX: --job-name=wobbly-egg-8322
#FLUX: --queue=amdgpu
#FLUX: -t=86400
#FLUX: --urgency=16

cd ..
ml torchsparse/1.4.0-foss-2021a-CUDA-11.3.1
python train.py configs/semantic_kitti/spvcnn/cr0p5.yaml --distributed False --ssl False
