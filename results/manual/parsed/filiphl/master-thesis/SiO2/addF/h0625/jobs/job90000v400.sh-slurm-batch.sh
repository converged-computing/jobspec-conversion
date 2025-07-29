#!/bin/bash
#FLUX: --job-name=filip90-4
#FLUX: -N=4
#FLUX: -t=36000
#FLUX: --urgency=16

source /cluster/bin/jobsetup
module load intel
module load intelmpi.intel
module load python2
mpirun -n 64 /work/users/henriasv/filip/lammps/src/lmp_intel_cpu_intelmpi -in inputScripts/system.run.90000v400
