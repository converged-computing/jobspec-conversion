#!/bin/bash
#FLUX: --job-name=lovable-onion-0648
#FLUX: -c=8
#FLUX: --urgency=16

export MIOPEN_DEBUG_DISABLE_FIND_DB='1'

module unload compiler/rocm/2.9
module rm compiler/rocm/2.9
module load apps/PyTorch/1.5.0a0/hpcx-2.4.1-gcc-7.3.1-rocm3.3
export MIOPEN_DEBUG_DISABLE_FIND_DB=1
python3 tools/train.py configs/faster_rcnn/faster_rcnn_r50_fpn_1x_coco.py --work-dir=./work1
