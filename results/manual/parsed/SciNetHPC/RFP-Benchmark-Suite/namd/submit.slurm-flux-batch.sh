#!/bin/bash
#FLUX: --job-name="LP2BM_NAMD"
#FLUX: -N=100
#FLUX: -t=3600
#FLUX: --priority=16

export NAMD_BIN='/scratch/s/scinet/willis2/rfp/benchmarks/NAMD_3.0b6_Source/Linux-x86_64-g++-memopt'

module load NiaEnv/2022a
module load gcc/11.3.0
module load openmpi/4.1.4+ucx-1.11.2
export NAMD_BIN=/scratch/s/scinet/willis2/rfp/benchmarks/NAMD_3.0b6_Source/Linux-x86_64-g++-memopt
$NAMD_BIN/charmrun ++p $SLURM_NTASKS $NAMD_BIN/namd3 $PWD/210stmv2fs.namd
