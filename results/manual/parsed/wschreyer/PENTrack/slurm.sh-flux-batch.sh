#!/bin/bash
#FLUX: --job-name=frigid-lemur-2514
#FLUX: -t=14400
#FLUX: --urgency=16

ID=$SLURM_ARRAY_TASK_ID  # Slurm array task index
JOB=$SLURM_ARRAY_JOB_ID  # Slurm job ID
./PENTrack $JOB$ID ./in/config.in ./out/
