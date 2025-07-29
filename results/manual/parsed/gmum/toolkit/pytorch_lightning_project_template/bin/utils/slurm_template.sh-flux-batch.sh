#!/bin/bash
#FLUX --job-name={batch_name}
#FLUX --queue=gpu4_medium,gpu4_long,gpu4_short,gpu8_short,gpu8_medium,gpu8_long
#FLUX -t=28800
#FLUX --urgency=16

export CUDA_VISIBLE_DEVICES='0'

cd /gpfs/home/jastrs01/cooperative_optimization
source /gpfs/home/jastrs01/cooperative_optimization/e_bigpurple.sh
export CUDA_VISIBLE_DEVICES=0
{job}
