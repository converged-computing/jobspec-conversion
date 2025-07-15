#!/bin/bash
#FLUX: --job-name=fep
#FLUX: -n=16
#FLUX: -t=43200
#FLUX: --urgency=16

module purge
module load   StdEnv/2020  intel/2020.1.217 namd-multicore/2.14
namd2 +p16 fep.conf > fep.out
