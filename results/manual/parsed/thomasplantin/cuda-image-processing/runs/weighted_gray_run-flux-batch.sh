#!/bin/bash
#FLUX: --job-name=a
#FLUX: --queue=gtx
#FLUX: -t=60
#FLUX: --urgency=16

module load cuda
module load gcc/7.3.0
cuda-memcheck ./a.out images/lena_rgb.png output_images/grayscale_weighted_lena.png grayweight single
