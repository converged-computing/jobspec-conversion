#!/bin/bash
#FLUX: --job-name=purple-train-7582
#FLUX: --urgency=16

source /cluster/bin/jobsetup
module load intel/2018.1
module load intelmpi.intel
lammps=$(find ~ -name lmp 2> /dev/null)
mpirun $lammps $@
