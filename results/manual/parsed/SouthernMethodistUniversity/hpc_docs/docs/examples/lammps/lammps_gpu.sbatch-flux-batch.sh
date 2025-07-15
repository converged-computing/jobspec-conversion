#!/bin/bash
#FLUX: --job-name=grated-latke-1118
#FLUX: --urgency=16

module purge                           # Unload all modules
module load lammps/may22               # Load LAMMPS
lmp\
 -k on g 1\
 -sf kk\
 -pk kokkos cuda/aware on neigh full comm device binsize 2.8\
 -var x 8 -var y 4 -var z 8\
 -in lammps_gpu.in
