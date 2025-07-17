#!/bin/bash
#FLUX: --job-name=quirky-avocado-2041
#FLUX: -n=8
#FLUX: --urgency=16

module load NAMD/2.13-GCC-7.3.0-2.30-OpenMPI-3.1.1
srun namd2 stmv.namd
