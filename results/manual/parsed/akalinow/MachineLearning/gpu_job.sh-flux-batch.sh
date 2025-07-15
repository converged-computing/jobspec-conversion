#!/bin/bash
#FLUX: --job-name=scruptious-lizard-8602
#FLUX: -t=600
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
myCalculations $SLURM_ARRAY_TASK_ID
