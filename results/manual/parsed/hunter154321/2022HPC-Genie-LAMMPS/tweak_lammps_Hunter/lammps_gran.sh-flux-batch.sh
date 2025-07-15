#!/bin/bash
#FLUX: --job-name=pusheena-itch-3712
#FLUX: -N=2
#FLUX: --priority=16

module add openmpi/4.1.2
cd /mnt/orangefs/hacker/2022HPC-Genie-LAMMPS/tweak_lammps_Hunter/
mpirun -np 40 /software/lammps/lammps-23Jun2022/src/lmp_mpi -in test-input-cylinder.txt
