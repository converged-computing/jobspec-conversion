#!/bin/bash
#FLUX: --job-name=peachy-poo-0173
#FLUX: --urgency=16

SINGULARITY_CONT=$PROJECT/psrsearch.sif
CMDDIR=$PROJECT/HPC_pulsar/cmd_files
singularity exec -B /local $SINGULARITY_CONT $CMDDIR/detrending.cmd
