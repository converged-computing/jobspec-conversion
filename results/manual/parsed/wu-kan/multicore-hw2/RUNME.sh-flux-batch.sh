#!/bin/bash
#FLUX: --job-name=boopy-taco-2371
#FLUX: --exclusive
#FLUX: --priority=16

mkdir -p sources/build
cd sources/build
rm -fr *
cmake ..
make
cd ../..
sources/build/main
