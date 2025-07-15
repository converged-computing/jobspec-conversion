#!/bin/bash
#FLUX: --job-name=lovable-pedo-2641
#FLUX: --urgency=16

export PATH='/es01/paratera/sce3063/lammps/lammps-2Aug2023/src:$PATH'

source /es01/paratera/parasoft/module.sh
module load mpi/intel/18
export PATH=/es01/paratera/sce3063/lammps/lammps-2Aug2023/src:$PATH
mpirun -np 2 lmp_intel_cpu_intelmpi -in i.gsf
