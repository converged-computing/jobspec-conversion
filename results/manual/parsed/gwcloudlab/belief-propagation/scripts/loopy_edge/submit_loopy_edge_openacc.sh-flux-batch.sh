#!/bin/bash
#FLUX: --job-name=misunderstood-car-8361
#FLUX: -t=25200
#FLUX: --urgency=16

module load cuda/toolkit
module load libxml2
module load cmake
cd ${HOME}/belief-propagation/src/openacc_benchmark
cmake . -DCMAKE_BUILD_TYPE=Release
make clean && make
rm -f *csv
./openacc_loopy_edge_benchmark
