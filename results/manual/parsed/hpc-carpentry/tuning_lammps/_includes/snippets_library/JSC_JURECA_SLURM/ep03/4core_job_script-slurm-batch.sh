#!/bin/bash
#SBATCH --account=ecam
#SBATCH --output=mpi-out.%j
#SBATCH --error=mpi-err.%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --constraint=ntasks-per-node=4

module purge
module use /usr/local/software/jureca/OtherStages
module load Stages/Devel-2019a
module load intel-para/2019a
module load LAMMPS/3Mar2020-Python-3.6.8-kokkos
srun lmp -in in.lj
