#!/bin/bash
#FLUX: --job-name=Lava_Wrapper
#FLUX: -n=40
#FLUX: --queue=C5
#FLUX: -t=3600
#FLUX: --priority=16

module purge
module load gnu8
module load openmpi3
mpirun /home/kqdang/LAVA_with_user_defined_phase/Lava_latest_03_09_22/lmp_mpi -in Lammps_Uniaxial_Deform.in -sf opt
