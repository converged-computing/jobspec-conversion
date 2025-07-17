#!/bin/bash
#FLUX: --job-name=WuK_scaffold
#FLUX: --exclusive
#FLUX: --queue=gpu_v100
#FLUX: --urgency=16

mkdir -p sources/build
cd sources/build
rm -fr *
cmake ..
make
cd ../..
sources/build/main
