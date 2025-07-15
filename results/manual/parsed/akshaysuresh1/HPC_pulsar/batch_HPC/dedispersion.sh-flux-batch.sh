#!/bin/bash
#FLUX: --job-name=pusheena-milkshake-7660
#FLUX: --urgency=16

SINGULARITY_CONT=$PROJECT/psrsearch.sif
CMDDIR=$PROJECT/HPC_pulsar/cmd_files
singularity exec -B /local $SINGULARITY_CONT $CMDDIR/dedispersion.cmd
