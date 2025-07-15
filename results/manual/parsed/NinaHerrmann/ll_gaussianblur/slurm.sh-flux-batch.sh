#!/bin/bash
#FLUX: --job-name=GaussianBlurLL_LL_REAL
#FLUX: -c=24
#FLUX: --exclusive
#FLUX: --queue=gpu2080
#FLUX: -t=36000
#FLUX: --priority=16

module load palma/2020b
module load fosscuda/2020b
cd /home/n/n_herr03/gaussianblur_ll/
nvcc main.cu -I include/ -arch=compute_75 -code=sm_75 -o build/gaussian
for kw in 8 10 12 14 16 18 20; do
	for tile_width in 8 16 32; do
		/home/n/n_herr03/gaussianblur_ll/build/gaussian 1 1 0 $tile_width 1 $kw
	done
	/home/n/n_herr03/gaussianblur_ll/build/gaussian 1 1 0 12 1 $kw
done
