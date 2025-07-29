#!/bin/bash
#FLUX --job-name=fuzzy-peanut-8238
#FLUX --queue=RM-shared
#FLUX -t=7200
#FLUX --urgency=16

SINGULARITY_CONT=$PROJECT/psrsearch.sif
CMDDIR=$PROJECT/HPC_pulsar/cmd_files
singularity exec -B /local $SINGULARITY_CONT $CMDDIR/baryfft.cmd
