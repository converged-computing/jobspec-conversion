#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --constraint=ntasks-per-node=40

module load lammps/2020/intel
mpiexec -np $SLURM_NTASKS lmp -in dpd_water_100x100x100_t1000.txt
