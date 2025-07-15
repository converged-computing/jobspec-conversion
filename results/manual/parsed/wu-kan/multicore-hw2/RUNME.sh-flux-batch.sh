#!/bin/bash
#FLUX: --job-name=dinosaur-poodle-2074
#FLUX: --exclusive
#FLUX: --urgency=16

mkdir -p sources/build
cd sources/build
rm -fr *
cmake ..
make
cd ../..
sources/build/main
