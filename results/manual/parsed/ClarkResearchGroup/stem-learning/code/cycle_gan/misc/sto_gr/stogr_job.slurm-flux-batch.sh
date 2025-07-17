#!/bin/bash
#FLUX: --job-name=tart-knife-7241
#FLUX: --queue=gpuA100x4
#FLUX: -t=21600
#FLUX: --urgency=16

module purge 
module list  
echo "job is starting on `hostname`"
singularity run --nv /sw/external/NGC/tensorflow:22.02-tf2-py3 python3 stogr_cycleGAN_for_STEM.py ${mat} ${num}
