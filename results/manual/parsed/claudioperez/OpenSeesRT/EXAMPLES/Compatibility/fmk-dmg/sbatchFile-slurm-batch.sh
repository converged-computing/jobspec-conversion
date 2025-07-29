#!/bin/bash
#SBATCH --job-name=myjob
#SBATCH --account=DesignSafe-SimCenter
#SBATCH --output=myjob.o%j
#SBATCH --error=myjob.e%j
#SBATCH --mail-user=fmckenna@berkeley.edu
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=9
#SBATCH --cpus-per-task=1
#SBATCH --time=20:00:00
#SBATCH --partition=small

module load intel
module load petsc
module load hdf5
set -x                                 #{echo cmds, use "set echo" in csh}
ibrun OpenSeesMP fmk3.tcl              # Run the MPI executable named "a.out"
