#!/bin/bash
#FLUX: --job-name=creamy-egg-8076
#FLUX: --priority=16

module use /share/apps2/singularity/modules
module purge
module load OpenFOAM
singularity_wrapper exec paraview
