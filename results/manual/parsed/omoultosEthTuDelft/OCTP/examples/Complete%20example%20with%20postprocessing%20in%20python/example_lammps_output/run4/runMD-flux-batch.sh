#!/bin/bash
#FLUX: --job-name=PostProcess_example
#FLUX: -n=12
#FLUX: --queue=parallel-12
#FLUX: -t=360000
#FLUX: --urgency=16

lmp=~/software/lammps/lam*22/src/ # getting the correct run file location
mpirun $lmp/lmp_mpi < simulation.in # computing with n cpu cores.
wait
exit 0
