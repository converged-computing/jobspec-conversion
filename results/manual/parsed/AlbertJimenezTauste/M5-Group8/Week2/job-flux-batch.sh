#!/bin/bash
#FLUX: --job-name=eccentric-car-5094
#FLUX: -n=4
#FLUX: --queue=mhigh,mhigh
#FLUX: --urgency=16

python detectron2_KITTI.py -p mhigh
