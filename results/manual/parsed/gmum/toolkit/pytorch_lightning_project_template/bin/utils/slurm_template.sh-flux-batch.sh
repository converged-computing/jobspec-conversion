#!/bin/bash
#FLUX: --job-name=stanky-citrus-4531
#FLUX: -t=28800
#FLUX: --urgency=16

export CUDA_VISIBLE_DEVICES='0'

cd /gpfs/home/jastrs01/cooperative_optimization
source /gpfs/home/jastrs01/cooperative_optimization/e_bigpurple.sh
export CUDA_VISIBLE_DEVICES=0
{job}
