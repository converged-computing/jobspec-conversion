#!/bin/bash
#FLUX: --job-name=gassy-kerfuffle-5365
#FLUX: --priority=16

module load cuda
module load gcc/7.3.0
cuda-memcheck ./a.out images/lena_rgb.png output_images/grayscale_weighted_lena.png grayweight single
