#!/bin/bash
#FLUX: --job-name=grated-fork-8833
#FLUX: --queue=RM-shared
#FLUX: -t=108000
#FLUX: --urgency=16

SINGULARITY_CONT=$PROJECT/psrsearch.sif
CMDDIR=$PROJECT/HPC_pulsar/cmd_files
singularity exec -B /local $SINGULARITY_CONT $CMDDIR/dedispersion.cmd
