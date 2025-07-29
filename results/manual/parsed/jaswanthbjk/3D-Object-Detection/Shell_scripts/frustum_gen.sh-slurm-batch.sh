#!/bin/bash
#FLUX: --job-name=frustum-Pointnet
#FLUX: --queue=any
#FLUX: -t=259200
#FLUX: --urgency=16

module load cuda
cd /home/jbandl2s/RnD/frustum-pointnets
python kitti/prepare_data.py --gen_val_rgb_detection
