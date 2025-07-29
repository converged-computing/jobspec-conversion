#!/bin/bash
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --constraint=ntasks-per-node=20

module add openmpi/4.1.2
cd /mnt/orangefs/hacker/2022HPC-Genie-LAMMPS/tweak_lammps_Hunter/
mpirun -np 40 /software/lammps/lammps-23Jun2022/src/lmp_mpi -in test-input-cylinder.txt
