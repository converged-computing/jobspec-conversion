#!/bin/bash
#FLUX: --job-name=muffled-poodle-8158
#FLUX: --queue=main
#FLUX: -t=86400
#FLUX: --urgency=16

export OPENMM_PLUGIN_DIR='/home/julien/sire.app/lib/plugins/'

echo "CUDA DEVICES:" $CUDA_VISIBLE_DEVICES
mkdir 10cycles
cd 10cycles
export OPENMM_PLUGIN_DIR=/home/julien/sire.app/lib/plugins/
srun ~/sire.app/bin/somd-freenrg -C ../sim10.cfg -l 0.50 -p CUDA
cd ..
