#!/bin/bash
#FLUX: --job-name=sticky-underoos-2942
#FLUX: --queue=mic
#FLUX: -t=14400
#FLUX: --urgency=16

setpkgs -a intel_cluster_studio_compiler
setpkgs -a lammps_mic
srun -n 2 lmp_intel_phi -in lammps.in
