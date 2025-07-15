#!/bin/bash
#FLUX: --job-name=conspicuous-peanut-butter-5538
#FLUX: --urgency=16

module load cuda
module load gcc/7.3.0
cuda-memcheck ./a.out images/lena_rgb.png output_images/average_grayscale_lena.png gray single
