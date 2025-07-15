#!/bin/bash
#FLUX: --job-name=swampy-soup-1898
#FLUX: --urgency=16

module use /share/apps2/singularity/modules
module purge
module load OpenFOAM
singularity_wrapper exec paraview
