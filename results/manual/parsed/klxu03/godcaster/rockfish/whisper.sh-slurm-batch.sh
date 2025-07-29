#!/bin/bash
#FLUX: --job-name=godcaster_whisper
#FLUX: -c=12
#FLUX: --queue=debug
#FLUX: -t=518400
#FLUX: --urgency=16

cd godcaster
cd src/captions
poetry run python main.py $SLURM_ARRAY_TASK_ID $SLURM_ARRAY_TASK_MAX 
