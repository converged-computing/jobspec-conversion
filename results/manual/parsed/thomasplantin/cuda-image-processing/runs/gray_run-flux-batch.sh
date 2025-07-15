#!/bin/bash
#FLUX: --job-name=anxious-peas-1060
#FLUX: --priority=16

module load cuda
module load gcc/7.3.0
cuda-memcheck ./a.out images/lena_rgb.png output_images/average_grayscale_lena.png gray single
