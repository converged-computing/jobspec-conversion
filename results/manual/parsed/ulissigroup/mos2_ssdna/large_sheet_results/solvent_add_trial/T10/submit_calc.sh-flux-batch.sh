#!/bin/bash
#FLUX: --job-name=namd
#FLUX: --queue=gpu
#FLUX: -t=604800
#FLUX: --priority=16

module purge; 
ulimit -Sn 4096; 
module load NAMD cuda
namd2 +p8 +isomalloc_sync fixed_mos2_solvate.namd
