#!/bin/bash
#FLUX --job-name=doopy-bike-4492
#FLUX --queue=RM-shared
#FLUX -t=18000
#FLUX --urgency=16

SINGULARITY_CONT=$PROJECT/psrsearch.sif
CMDDIR=$PROJECT/HPC_pulsar/cmd_files
singularity exec -B /local $SINGULARITY_CONT $CMDDIR/detrending.cmd
