#!/bin/bash
#FLUX: --job-name=scRATE
#FLUX: -c=4
#FLUX: --queue=compute
#FLUX: -t=86399
#FLUX: --urgency=16

module load singularity
ARRAY_ID=`printf %05d $SLURM_ARRAY_TASK_ID`
singularity run --app Rscript ${CONTAINER} ${RFILE} _chunk.${ARRAY_ID} _scrate.${ARRAY_ID} ${CORES} ${SEED}
