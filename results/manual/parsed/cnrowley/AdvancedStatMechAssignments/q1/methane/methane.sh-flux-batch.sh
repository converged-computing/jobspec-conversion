#!/bin/bash
#FLUX: --job-name=methane
#FLUX: -n=4
#FLUX: -t=10800
#FLUX: --urgency=16

module purge
module load   StdEnv/2020  intel/2020.1.217 namd-multicore/2.14
namd2 +p4 methane.conf > methane.out
