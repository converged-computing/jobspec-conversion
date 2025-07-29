#!/bin/bash
#SBATCH --output=
#SBATCH --error=
#SBATCH --mail-user=galvisf@stanford.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=5
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8000
#SBATCH --partition=cee,owners
#SBATCH --qos=normal
#SBATCH --constraint=ntasks-per-node=16

module load openmpi
module load scalapack
module load mumps
module load metis
module load parmetis
module load petsc
srun /home/users/galvisf/bin/OpenSeesMP30 RunMSAParallel.tcl
