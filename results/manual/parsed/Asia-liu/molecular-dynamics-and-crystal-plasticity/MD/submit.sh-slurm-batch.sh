#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1

export PATH='/es01/paratera/sce3063/lammps/lammps-2Aug2023/src:$PATH'

source /es01/paratera/parasoft/module.sh
module load mpi/intel/18
export PATH=/es01/paratera/sce3063/lammps/lammps-2Aug2023/src:$PATH
mpirun -np 2 lmp_intel_cpu_intelmpi -in i.gsf
