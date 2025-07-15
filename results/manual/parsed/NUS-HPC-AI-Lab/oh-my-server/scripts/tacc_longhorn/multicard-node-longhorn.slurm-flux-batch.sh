#!/bin/bash
#FLUX: --job-name=boopy-avocado-0397
#FLUX: --priority=16

pwd
date
cd /scratch/07801/nusbin20/tacc-our
module load conda
conda activate py36pt
ibrun -np 8 \
python examples/pytorch_imagenet_resnet.py \
--epochs 90 \
--model resnet50
