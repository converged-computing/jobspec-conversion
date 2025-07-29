#!/bin/bash
#FLUX: --job-name=o2-pentane_long
#FLUX: -n=8
#FLUX: -t=10800
#FLUX: --urgency=16

module purge
module load   StdEnv/2020  intel/2020.1.217 namd-multicore/2.14
namd2 +p8 eq_long.conf > eq_long.out
namd2 +p8 prod_long.conf > prod_long.out
