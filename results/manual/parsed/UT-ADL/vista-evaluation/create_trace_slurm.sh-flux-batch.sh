#!/bin/bash
#FLUX: --job-name=fugly-plant-7503
#FLUX: -c=24
#FLUX: --queue=amd
#FLUX: --urgency=16

srun python -u create_trace.py "$@"
