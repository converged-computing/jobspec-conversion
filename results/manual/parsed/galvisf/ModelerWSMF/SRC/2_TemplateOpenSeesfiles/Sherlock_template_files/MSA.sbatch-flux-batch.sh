#!/bin/bash
#FLUX: --job-name=red-salad-8829
#FLUX: -N=5
#FLUX: --queue=cee,owners
#FLUX: --urgency=16

module load openmpi
module load scalapack
module load mumps
module load metis
module load parmetis
module load petsc
srun /home/users/galvisf/bin/OpenSeesMP30 RunMSAParallel.tcl
