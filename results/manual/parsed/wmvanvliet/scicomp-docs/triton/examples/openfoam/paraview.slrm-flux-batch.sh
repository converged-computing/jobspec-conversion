#!/bin/bash
#FLUX: --job-name=boopy-toaster-8005
#FLUX: -t=600
#FLUX: --priority=16

module use /share/apps2/singularity/modules
module purge
module load OpenFOAM
singularity_wrapper exec paraview
