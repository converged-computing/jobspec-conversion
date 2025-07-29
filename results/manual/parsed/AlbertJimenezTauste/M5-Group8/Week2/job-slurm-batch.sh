#!/bin/bash
#FLUX: --job-name=conspicuous-lettuce-0287
#FLUX: -n=4
#FLUX: --queue=mhigh,mhigh
#FLUX: --urgency=16

python detectron2_KITTI.py -p mhigh
