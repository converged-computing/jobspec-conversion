#!/bin/bash
#FLUX: --job-name=hairy-rabbit-1586
#FLUX: -c=12
#FLUX: --queue=gpu-a100-tmp
#FLUX: -t=14400
#FLUX: --urgency=16

export FLAMEGPU2_INC_DIR='_deps/flamegpu2-src/include'

module unuse /usr/local/modulefiles/live/eb/all
module unuse /usr/local/modulefiles/live/noeb
module use /usr/local/modulefiles/staging/eb-znver3/all/
module load GCC/11.2.0
module load CUDA/11.4.1
PROJECT_ROOT=../..
cd $PROJECT_ROOT
cd build
export FLAMEGPU2_INC_DIR=_deps/flamegpu2-src/include
nvidia-smi
./bin/Release/ensemble-benchmark
