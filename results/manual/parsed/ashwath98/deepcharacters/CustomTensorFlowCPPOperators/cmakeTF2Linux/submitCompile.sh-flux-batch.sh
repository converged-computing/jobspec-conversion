#!/bin/bash
#FLUX: --job-name=evasive-snack-4699
#FLUX: --queue=gpu20
#FLUX: -t=172800
#FLUX: --urgency=16

echo "using GPU ${CUDA_VISIBLE_DEVICES}"
cd ../build/Linux
make -j 32
