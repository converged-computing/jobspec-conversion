#!/bin/bash
#FLUX: --job-name=IDAne1
#FLUX: -N=5
#FLUX: -t=57600
#FLUX: --urgency=16

module load openmpi
module load scalapack
module load mumps
module load metis
module load parmetis
module load petsc
srun /home/users/galvisf/bin/OpenSeesMP30 RunIDAParallel_NESTED.tcl
