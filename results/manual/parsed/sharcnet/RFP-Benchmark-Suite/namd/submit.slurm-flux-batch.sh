#!/bin/bash
#FLUX: --job-name=strawberry-chip-6346
#FLUX: -N=4
#FLUX: -t=3000
#FLUX: --urgency=16

export NAMD_BIN='/home/ppomorsk/projects/def-ppomorsk/benchmarks/stmv/Linux-x86_64-g++-memopt'

module load StdEnv/2023 gcc/12.3 openmpi/4.1.5
export NAMD_BIN=/home/ppomorsk/projects/def-ppomorsk/benchmarks/stmv/Linux-x86_64-g++-memopt
$NAMD_BIN/charmrun ++p $SLURM_NTASKS $NAMD_BIN/namd3 20stmv2fs.namd 
