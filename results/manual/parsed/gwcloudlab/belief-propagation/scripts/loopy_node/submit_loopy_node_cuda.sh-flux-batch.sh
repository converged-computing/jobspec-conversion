#!/bin/bash
#FLUX: --job-name=grated-staircase-4776
#FLUX: -t=25200
#FLUX: --urgency=16

module load cuda/toolkit
module load libxml2
module load cmake
cd ${HOME}/belief-propagation/src/cuda_benchmark
cmake . -DCMAKE_BUILD_TYPE=Release
make clean && make
rm -f *csv
./cuda_node_benchmark
