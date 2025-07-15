#!/bin/bash
#FLUX: --job-name=singularity_test
#FLUX: --queue=gpu-2080ti
#FLUX: -t=60
#FLUX: --urgency=16

./singularity_run.sh run 0 python3 bias_transfer_recipes/main.py --recipe $1 --experiment $2
