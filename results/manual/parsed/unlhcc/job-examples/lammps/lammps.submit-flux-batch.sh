#!/bin/bash
#FLUX: --job-name=lammps_example
#FLUX: -n=4
#FLUX: -t=900
#FLUX: --urgency=16

module purge
module load compiler/gcc/11 openmpi/4.1 lammps/23June2022
mpirun lmp < in.atm
