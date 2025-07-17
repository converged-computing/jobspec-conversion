#!/bin/bash
#FLUX: --job-name=swbench
#FLUX: -c=40
#FLUX: -t=2700
#FLUX: --urgency=16

THREADS=20
module load NiaEnv/.2022a
module load intel/2022u2
module load cmake
module load gcc
echo "----- Building swbench -----"
rm -rf build
mkdir -p build && cd build
cmake -DCMAKE_BUILD_TYPE=Release -DPAPI_PREFIX=${HOME}/programs/papi/  ..
cmake --build . --config Release -- -j4
