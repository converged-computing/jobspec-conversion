#!/bin/bash
#FLUX: --job-name=myjob
#FLUX: -n=9
#FLUX: --queue=small
#FLUX: -t=72000
#FLUX: --urgency=16

module load intel
module load petsc
module load hdf5
set -x                                 #{echo cmds, use "set echo" in csh}
ibrun OpenSeesMP fmk3.tcl              # Run the MPI executable named "a.out"
