#!/bin/bash
#FLUX: --job-name=doopy-kitty-0044
#FLUX: -t=345600
#FLUX: --urgency=16

export LD_LIBRARY_PATH='/opt/lammps-7Aug19_nnp_plumed/lib/nnp/lib'

module load openmpi/4.0.0
export LD_LIBRARY_PATH=/opt/lammps-7Aug19_nnp_plumed/lib/nnp/lib
mpirun -np 10 /opt/lammps-7Aug19_nnp_plumed/src/lmp_mpi < in.lmp
echo "completed 1"
