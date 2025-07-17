#!/bin/bash
#FLUX: --job-name=ms
#FLUX: --queue=sched_mit_ccoley
#FLUX: -t=18000
#FLUX: --urgency=16

conda activate ms-gen
echo "Cuda visible:"
echo $CUDA_VISIBLE_DEVICES
eval $CMD
