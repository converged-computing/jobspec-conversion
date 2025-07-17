#!/bin/bash
#FLUX: --job-name=confused-toaster-3103
#FLUX: -c=8
#FLUX: --queue=pi_cryoem,scavenge
#FLUX: -t=1440
#FLUX: --urgency=16

module load NAMD/2.13-multicore-CUDA
namd2 +idlepoll +ppn $SLURM_CPUS_ON_NODE stmv.namd 
