#!/bin/bash
#FLUX: --job-name=purple-plant-0201
#FLUX: --priority=16

module load NAMD/2.13-GCC-7.3.0-2.30-OpenMPI-3.1.1
srun namd2 stmv.namd
