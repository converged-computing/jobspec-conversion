#!/bin/bash
#FLUX: --job-name=joyous-eagle-2234
#FLUX: -t=86400
#FLUX: --urgency=16

export OPENMM_PLUGIN_DIR='/home/julien/sire.app/lib/plugins/'

echo "CUDA DEVICES:" $CUDA_VISIBLE_DEVICES
mkdir 100cycles
cd 100cycles
export OPENMM_PLUGIN_DIR=/home/julien/sire.app/lib/plugins/
srun ~/sire.app/bin/somd-freenrg -C ../sim100.cfg -l 0.50 -p CUDA
cd ..
