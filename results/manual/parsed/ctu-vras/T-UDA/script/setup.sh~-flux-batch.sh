#!/bin/bash
#FLUX --job-name=expensive-kitty-8952
#FLUX --queue=amdgpu
#FLUX -t=86400
#FLUX --urgency=16

python train.py configs/semantic_kitti/spvcnn/cr0p5.yaml --distributed False
