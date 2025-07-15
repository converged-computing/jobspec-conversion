#!/bin/bash
#FLUX: --job-name=expensive-animal-1897
#FLUX: -t=25200
#FLUX: --priority=16

module load cuda/toolkit
module load libxml2
module load cmake
cd ${HOME}/belief-propagation/src/openacc_benchmark
cmake . -DCMAKE_BUILD_TYPE=Release
make clean && make
rm -f *csv
./openacc_loopy_edge_benchmark
