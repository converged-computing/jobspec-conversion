#!/bin/bash
#FLUX: --job-name=reclusive-pedo-0989
#FLUX: --priority=16

SINGULARITY_CONT=$PROJECT/psrsearch.sif
CMDDIR=$PROJECT/HPC_pulsar/cmd_files
singularity exec -B /local $SINGULARITY_CONT $CMDDIR/baryfft.cmd
