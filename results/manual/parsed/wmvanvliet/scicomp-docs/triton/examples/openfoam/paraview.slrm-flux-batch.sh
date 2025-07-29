#!/bin/bash
#FLUX --job-name=strawberry-plant-3622
#FLUX -t=600
#FLUX --urgency=16

module use /share/apps2/singularity/modules
module purge
module load OpenFOAM
singularity_wrapper exec paraview
