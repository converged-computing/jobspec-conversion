#!/bin/bash
#FLUX: --job-name=hello-puppy-2692
#FLUX: --priority=16

module load intel
module load petsc
module load hdf5
set -x                                 #{echo cmds, use "set echo" in csh}
ibrun OpenSeesMP fmk3.tcl              # Run the MPI executable named "a.out"
