#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --constraint=ntasks-per-node=64

module load openmpi/4.1.1/amd-intel
module load lammps/2020/amd-intel
which lmp
bash run_dpd_water_mpi_helper.sh mpi_amd_n1_t64
