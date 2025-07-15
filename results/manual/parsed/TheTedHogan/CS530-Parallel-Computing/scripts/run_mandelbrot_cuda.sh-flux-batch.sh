#!/bin/bash
#FLUX: --job-name=chunky-knife-1977
#FLUX: --urgency=16

module load gcc/9.2.0
module load cmake/gcc/3.18.0
module load openmpi/gcc/64/1.10.7
module load nvidia_hpcsdk
cd build
rm -rf *
cmake ..
make
./mandelbrot_cuda pic.ppm
