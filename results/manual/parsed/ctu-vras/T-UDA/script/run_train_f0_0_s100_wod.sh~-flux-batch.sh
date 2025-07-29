#!/bin/bash
#FLUX --job-name=anxious-cupcake-6694
#FLUX --queue=amdgpufast
#FLUX -t=14400
#FLUX --urgency=16

cd ..
ml torchsparse/1.4.0-foss-2021a-CUDA-11.3.1
python train.py configs/semantic_kitti/spvcnn/default.yaml --distributed False --ssl False
