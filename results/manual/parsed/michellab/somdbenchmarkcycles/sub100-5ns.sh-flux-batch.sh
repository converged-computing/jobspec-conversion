#!/bin/bash
#FLUX: --job-name=frigid-buttface-2034
#FLUX: --queue=main
#FLUX: -t=86400
#FLUX: --urgency=16

export OPENMM_PLUGIN_DIR='/home/julien/sire.app/lib/plugins/'

echo "CUDA DEVICES:" $CUDA_VISIBLE_DEVICES
mkdir 100cycles-5ns
cd 100cycles-5ns
export OPENMM_PLUGIN_DIR=/home/julien/sire.app/lib/plugins/
srun ~/sire.app/bin/somd-freenrg -C ../sim100-5ns.cfg -l 0.50 -p CUDA
cd ..
