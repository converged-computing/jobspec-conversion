#!/bin/bash
#FLUX: --job-name=expressive-pastry-5386
#FLUX: --urgency=16

pwd
date
cd /scratch/07801/nusbin20/tacc-our
module load conda
conda activate py36pt
ibrun -np 8 \
python examples/pytorch_imagenet_resnet.py \
--epochs 90 \
--model resnet50
