#!/bin/bash
#FLUX: --job-name=lstm
#FLUX: --queue=gpu-a100
#FLUX: -t=19800
#FLUX: --urgency=16

python /work/07965/clans/ls6/Spring_RASR/rasr/scripts/model_test.py          # Do not use ibrun or any other MPI launcher
