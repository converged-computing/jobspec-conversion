#!/bin/bash
#FLUX: --job-name=seg
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

echo "----------------- Environment ------------------"
module purge
module load EasyBuild/2023a
module load CUDA/12.2.0
module list
micromamba activate CropMAE
cd ~/CropMAE
date
python3 -m downstreams.propagation.start \
    results \
    399 \
    $1
