#!/bin/bash
#FLUX: --job-name=prepros
#FLUX: -t=172800
#FLUX: --urgency=16

module load Singularity
singularity exec -H /g/acvt/a1720858/sastvd main.sif python -u sastvd/scripts/getgraphs.py $SLURM_ARRAY_TASK_ID
