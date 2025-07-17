#!/bin/bash
#FLUX: --job-name=rasr_TACC_test
#FLUX: --queue=normal
#FLUX: -t=12600
#FLUX: --urgency=16

bash /work/07965/clans/ls6/Spring_RASR/run/rasr_activator_test         # Do not use ibrun or any other MPI launcher
