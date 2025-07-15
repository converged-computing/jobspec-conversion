#!/bin/bash
#FLUX: --job-name=LTMU
#FLUX: -n=2
#FLUX: -c=2
#FLUX: --queue=gpu --gres=gpu:teslav100:1
#FLUX: -t=604800
#FLUX: --priority=16

module load CUDA/10.0
module load fgci-common
module load ninja/1.9.0
module load all/libjpeg-turbo/2.0.0-GCCcore-7.3.0
cd /home/yans/LTMU-rgbd/DiMP_LTMU/
source activate DiMP_LTMU
python Demo.py
conda deactivate
