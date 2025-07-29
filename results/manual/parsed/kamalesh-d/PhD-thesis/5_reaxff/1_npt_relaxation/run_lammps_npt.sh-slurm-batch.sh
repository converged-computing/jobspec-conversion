#!/bin/bash
#SBATCH --job-name=Test_lammps_CPU
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --constraint=[HSW24|BDW28]

module purge
module load intel/17.2 openmpi/intel/2.0.1 
module load lammps/17Nov16
cd $PWD
time srun lmp_icc_openmpi < in.interface
