#!/bin/bash
#FLUX: --job-name=fuzzy-animal-6594
#FLUX: --urgency=16

module load libraries/openmpi/5.0.3/gcc-13
mpirun --map-by core $HOME/NAMD_3.0b6_Source/Linux-ARM64-g++/namd3 $HOME/NAMD_3.0b6_Source/Linux-ARM64-g++/stmv/stmv.namd
