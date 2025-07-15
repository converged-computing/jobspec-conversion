#!/bin/bash
#FLUX: --job-name=salted-noodle-6182
#FLUX: --priority=16

module load NAMD/2.13-multicore-CUDA
namd2 +idlepoll +ppn $SLURM_CPUS_ON_NODE stmv.namd 
