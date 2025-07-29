#!/bin/bash
#FLUX: --job-name=fep
#FLUX: -n=8
#FLUX: -t=86400
#FLUX: --urgency=16

module purge
module load   StdEnv/2020  intel/2020.1.217 namd-multicore/2.14
namd2 +p8 fep.conf > fep.out
