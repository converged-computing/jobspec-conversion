#!/bin/bash
#FLUX: --job-name=exp_classifier
#FLUX: --queue=gpu-a100
#FLUX: -t=19800
#FLUX: --urgency=16

python /work/07965/clans/ls6/Spring_RASR/rasr/rasr/network/experimental_classifier.py          # Do not use ibrun or any other MPI launcher
