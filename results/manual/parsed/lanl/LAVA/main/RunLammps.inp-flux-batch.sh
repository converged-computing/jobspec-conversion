#!/bin/bash
#FLUX: --job-name=Lava_Wrapper
#FLUX: -n=40
#FLUX: --queue=C5
#FLUX: -t=3600
#FLUX: --priority=16

module purge
module load gnu8
module load openmpi3
mpirun lammps_executable -in lammps.in -sf opt
