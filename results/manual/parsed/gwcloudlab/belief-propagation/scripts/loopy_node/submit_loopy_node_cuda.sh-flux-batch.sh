#!/bin/bash
#FLUX: --job-name=eccentric-eagle-5751
#FLUX: -t=25200
#FLUX: --priority=16

module load cuda/toolkit
module load libxml2
module load cmake
cd ${HOME}/belief-propagation/src/cuda_benchmark
cmake . -DCMAKE_BUILD_TYPE=Release
make clean && make
rm -f *csv
./cuda_node_benchmark
