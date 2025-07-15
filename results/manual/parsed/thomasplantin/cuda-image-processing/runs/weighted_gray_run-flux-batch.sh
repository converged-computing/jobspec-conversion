#!/bin/bash
#FLUX: --job-name=stinky-snack-8377
#FLUX: --urgency=16

module load cuda
module load gcc/7.3.0
cuda-memcheck ./a.out images/lena_rgb.png output_images/grayscale_weighted_lena.png grayweight single
