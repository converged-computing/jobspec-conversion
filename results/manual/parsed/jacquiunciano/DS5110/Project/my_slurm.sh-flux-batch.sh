#!/bin/bash
#FLUX: --job-name=data_sys
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=1800
#FLUX: --urgency=16

module purge
module load apptainer/1.2.2 pytorch/2.0.1 java/11 gcc/11.4.0 openmpi/4.1.4 python/3.11.4 spark/3.4.1
apptainer exec --nv $CONTAINERDIR/pytorch-2.0.1.sif Documents/MSDS/DS5110/Project/sdl_debugger.py 
