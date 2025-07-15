#!/bin/bash
#FLUX: --job-name=crunchy-animal-2961
#FLUX: --urgency=16

module load NAMD/2.13-GCC-7.3.0-2.30-OpenMPI-3.1.1
srun namd2 stmv.namd
