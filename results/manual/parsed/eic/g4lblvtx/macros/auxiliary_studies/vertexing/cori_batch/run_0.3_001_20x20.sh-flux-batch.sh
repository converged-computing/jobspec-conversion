#!/bin/bash
#FLUX: --job-name=astute-gato-2046
#FLUX: -t=1200
#FLUX: --urgency=16

shifter ./shifter.sh $SLURM_ARRAY_TASK_ID 100000 0 0 1 0.3 20
