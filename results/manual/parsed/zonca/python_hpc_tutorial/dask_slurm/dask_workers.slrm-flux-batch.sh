#!/bin/bash
#FLUX: --job-name="dask-workers"
#FLUX: -N=2
#FLUX: --queue=compute
#FLUX: --priority=16

export SINGULARITY_BINDPATH='/oasis'

module load singularity
SINGULARITY_IMAGE="/oasis/scratch/comet/zonca/temp_project/zonca-singularity-comet-master-2019-05.simg"
COMMAND="bash ./launch_worker.sh"
export SINGULARITY_BINDPATH="/oasis"
ibrun --npernode=1 singularity exec $SINGULARITY_IMAGE $COMMAND
