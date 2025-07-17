#!/bin/bash
#FLUX: --job-name=boopy-puppy-8624
#FLUX: -c=24
#FLUX: --queue=gpu
#FLUX: -t=28800
#FLUX: --urgency=16

export FLAMEGPU2_INC_DIR='_deps/flamegpu2-src/include'

module load GCC/11.3.0
module load CUDA/12.0.0
PROJECT_ROOT=../..
cd $PROJECT_ROOT
cd build
export FLAMEGPU2_INC_DIR=_deps/flamegpu2-src/include
echo "HOSTNAME=${HOSTNAME}"
nvidia-smi
./bin/Release/circles-benchmark
