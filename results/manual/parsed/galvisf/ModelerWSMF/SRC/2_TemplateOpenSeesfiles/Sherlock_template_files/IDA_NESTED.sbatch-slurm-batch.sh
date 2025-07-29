#!/bin/bash
#SBATCH --job-name=IDAne1
#SBATCH --output=IDAne1.out
#SBATCH --error=IDAne1.err
#SBATCH --mail-user=galvisf@stanford.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=5
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4000
#SBATCH --time=16:00:00
#SBATCH --partition=cee
#SBATCH --qos=normal
#SBATCH --constraint=ntasks-per-node=16

module load openmpi
module load scalapack
module load mumps
module load metis
module load parmetis
module load petsc
srun /home/users/galvisf/bin/OpenSeesMP30 RunIDAParallel_NESTED.tcl
