#!/bin/bash
#FLUX: --job-name=scruptious-staircase-6342
#FLUX: --priority=16

python /work/07965/clans/ls6/Spring_RASR/rasr/scripts/model_test.py          # Do not use ibrun or any other MPI launcher
