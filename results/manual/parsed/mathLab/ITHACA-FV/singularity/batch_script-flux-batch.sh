#!/bin/bash
#FLUX: --job-name=singularity
#FLUX: --urgency=16

module load singularity/3.4.1
module load intel/2021.2
module load openmpi3
echo "Starting singularity on host $HOSTNAME"
singularity exec ithicafv.sif /bin/bash Of.sh
echo "Completed singularity on host $HOSTNAME"
