#!/bin/bash
#FLUX: --job-name=pusheena-banana-4207
#FLUX: --priority=16

python /work/07965/clans/ls6/Spring_RASR/rasr/rasr/network/experimental_classifier.py          # Do not use ibrun or any other MPI launcher
