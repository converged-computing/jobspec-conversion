#!/bin/bash
#FLUX: --job-name=quantWrite
#FLUX: -c=2
#FLUX: --queue=mghpcc-short
#FLUX: -t=21600
#FLUX: --urgency=16

export LC_ALL='C'

export LC_ALL=C
source $1/settings/settings.sh
module load singularity
singularity exec --bind $inputdirectory,$outputdirectory,$fragpipeDirectory $container $1/settings/IonQuant/Write_quantindex.sh "$1" "$SLURM_JOBID" "$SLURM_ARRAY_TASK_ID"
