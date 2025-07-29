#!/bin/bash
#FLUX: --job-name=final
#FLUX: --queue=gpu-rtx6k
#FLUX: -t=900
#FLUX: --urgency=16

module load cuda
rm *.csv
source build_oblas_cublas.sh;
source build_mem_swaps.sh;
source build_file_swaps.sh;
source build_cpu_gpu_bw.sh;
source build_fftw.sh;
source build_cufft.sh;
rm *.o x*
