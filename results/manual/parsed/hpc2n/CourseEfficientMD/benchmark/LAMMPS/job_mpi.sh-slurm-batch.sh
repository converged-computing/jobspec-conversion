#!/bin/bash
#SBATCH --account=SNICyyyy-xx-yy
#SBATCH --nodes=1
#SBATCH --ntasks=28
#SBATCH --cpus-per-task=1
#SBATCH --time=02:10:00

ml GCC/8.3.0  OpenMPI/3.1.4
ml LAMMPS/3Mar2020-Python-3.7.4-kokkos
srun lmp -in step4.1_equilibration.inp
