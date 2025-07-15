#!/bin/bash
#FLUX: --job-name=nerdy-dog-2041
#FLUX: -c=24
#FLUX: --queue=amd
#FLUX: --priority=16

srun python -u create_trace.py "$@"
