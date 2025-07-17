#!/bin/bash
#FLUX: --job-name=quirky-staircase-1587
#FLUX: --queue=main
#FLUX: -t=86400
#FLUX: --urgency=16

export OPENMM_PLUGIN_DIR='/home/julien/sire.app/lib/plugins/'

echo "CUDA DEVICES:" $CUDA_VISIBLE_DEVICES
mkdir 100cycles-1ns-nocoords
cd 100cycles-1ns-nocoords
export OPENMM_PLUGIN_DIR=/home/julien/sire.app/lib/plugins/
srun ~/sire.app/bin/somd-freenrg -C ../sim100-1ns-nocoords.cfg -l 0.50 -p CUDA
cd ..
