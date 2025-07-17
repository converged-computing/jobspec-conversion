#!/bin/bash
#FLUX: --job-name=train
#FLUX: -c=24
#FLUX: --queue=amd
#FLUX: -t=86340
#FLUX: --urgency=16

srun python -u create_trace.py "$@"
