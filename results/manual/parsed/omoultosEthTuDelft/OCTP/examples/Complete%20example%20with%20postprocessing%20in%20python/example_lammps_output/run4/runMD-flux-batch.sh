#!/bin/bash
#FLUX: --job-name="PostProcess_example"
#FLUX: --priority=16

lmp=~/software/lammps/lam*22/src/ # getting the correct run file location
mpirun $lmp/lmp_mpi < simulation.in # computing with n cpu cores.
wait
exit 0
