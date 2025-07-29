#!/bin/bash
#SBATCH --job-name=SMAM
#SBATCH --output=testMRF2.out
#SBATCH --error=testMRF2.err
#SBATCH --mail-user=wyen@stanford.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=44
#SBATCH --cpus-per-task=1
#SBATCH --time=3-00:00:00
#SBATCH --qos=normal

module load openmpi
module load scalapack
module load mumps
module load metis
module load parmetis
module load petsc
srun /home/users/wyen/bin/OpenSeesMP /home/users/wyen/MRF31_191103/MRF/Main.tcl
