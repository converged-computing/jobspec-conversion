#!/bin/bash
#FLUX: --job-name=lama_spatial
#FLUX: -c=16
#FLUX: -t=86400
#FLUX: --urgency=16

module load singularity
singularity exec LAMA.sif lama_workspace/spatially_normalise_data.sh 2> lama_workspace/lama_spatial_$SLURM_ARRAY_TASK_ID.err 1> lama_workspace/lama_spatial_$SLURM_ARRAY_TASK_ID.out
