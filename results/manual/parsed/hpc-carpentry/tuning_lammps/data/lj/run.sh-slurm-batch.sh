#!/bin/bash
#SBATCH --account=ecam
#SBATCH --output=mpi-out.%j
#SBATCH --error=mpi-err.%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:15:00
#SBATCH --constraint=ntasks-per-node=1

module use /usr/local/software/jureca/OtherStages
module load Stages/Devel-2019a
module load intel-para/2019a
module load LAMMPS/9Jan2020-cuda
srun lmp < in.lj|tee out.lj
