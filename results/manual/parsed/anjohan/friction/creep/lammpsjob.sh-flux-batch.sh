#!/bin/bash
#FLUX: --job-name=pusheena-egg-7444
#FLUX: --priority=16

source /cluster/bin/jobsetup
module load intel/2018.1
module load intelmpi.intel
lammps=$(find ~ -name lmp 2> /dev/null)
mpirun $lammps $@
