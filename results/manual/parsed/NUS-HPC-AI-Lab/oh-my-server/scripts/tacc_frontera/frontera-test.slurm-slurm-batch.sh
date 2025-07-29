#!/bin/bash
#FLUX: --job-name=myjob
#FLUX: -N=2
#FLUX: -n=8
#FLUX: --queue=rtx
#FLUX: -t=600
#FLUX: --urgency=16

pwd
date
source ~/python-env/cuda10-home/bin/activate
cd /scratch1/07801/nusbin20/tacc-our
module load intel/18.0.5 impi/18.0.5
module load cuda/10.1 cudnn nccl
ibrun -np 8 \
	python pytorch_imagenet_resnet.py  \
	--epochs 90 \
	--model resnet50
