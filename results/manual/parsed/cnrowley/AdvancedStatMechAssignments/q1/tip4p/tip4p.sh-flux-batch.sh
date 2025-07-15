#!/bin/bash
#FLUX: --job-name=tip4p-fb
#FLUX: -n=8
#FLUX: -t=10800
#FLUX: --urgency=16

module purge
module load   StdEnv/2020  intel/2020.1.217 namd-multicore/2.14
namd2 +p8 tip4p-fb.conf > tip4p-fb.out
