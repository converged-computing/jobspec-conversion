#!/bin/bash
#FLUX --job-name=fugly-underoos-4630
#FLUX --queue=amdgpu
#FLUX -t=86400
#FLUX --urgency=16

python train.py configs/semantic_kitti/spvcnn/cr0p5.yaml --distributed False
