#!/bin/bash
#FLUX: --job-name=dirty-pancake-9435
#FLUX: --urgency=16

module load NAMD/2.13-multicore-CUDA
namd2 +idlepoll +ppn $SLURM_CPUS_ON_NODE stmv.namd 
