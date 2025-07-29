#!/bin/bash
#FLUX --job-name=butterscotch-earthworm-0660
#FLUX -n=4
#FLUX --queue=mhigh,mhigh
#FLUX --urgency=16

python detectron2_KITTI.py -p mhigh
