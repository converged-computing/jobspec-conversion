#!/bin/bash
#FLUX: --job-name=build_fgpu2_nb
#FLUX: --queue=plgrid
#FLUX: -t=1800
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
module load cmake/3.20.1-gcccore-10.3.0
module load cudacore/11.2.2
mkdir -p build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DVISUALISATION=OFF -DSEATBELTS=OFF -DCUDA_ARCH="70"
cmake --build . --target all --parallel 4
