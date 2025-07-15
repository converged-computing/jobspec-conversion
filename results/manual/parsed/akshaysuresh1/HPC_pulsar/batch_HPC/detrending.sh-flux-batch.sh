#!/bin/bash
#FLUX: --job-name=hanky-dog-9844
#FLUX: --priority=16

SINGULARITY_CONT=$PROJECT/psrsearch.sif
CMDDIR=$PROJECT/HPC_pulsar/cmd_files
singularity exec -B /local $SINGULARITY_CONT $CMDDIR/detrending.cmd
