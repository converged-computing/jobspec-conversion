#!/bin/bash
#FLUX: --job-name=SMAM
#FLUX: -n=44
#FLUX: -t=259200
#FLUX: --priority=16

module load openmpi
module load scalapack
module load mumps
module load metis
module load parmetis
module load petsc
srun /home/users/wyen/bin/OpenSeesMP /home/users/wyen/MRF31_191103/MRF/Main.tcl
