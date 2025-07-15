#!/bin/bash
#FLUX: --job-name=dinosaur-poodle-6857
#FLUX: --urgency=16

echo "using GPU ${CUDA_VISIBLE_DEVICES}"
cd ../build/Linux
make -j 32
