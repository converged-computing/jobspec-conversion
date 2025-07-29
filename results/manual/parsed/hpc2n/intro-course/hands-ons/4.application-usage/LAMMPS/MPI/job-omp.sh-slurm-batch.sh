#!/bin/bash
#SBATCH --account=Project_ID
#SBATCH --nodes=1
#SBATCH --ntasks=14
#SBATCH --cpus-per-task=2
#SBATCH --time=00:10:00

export OMP_NUM_THREADS='2'

ml purge > /dev/null 2>&1
ml GCC/8.3.0  OpenMPI/3.1.4
ml LAMMPS/3Mar2020-Python-3.7.4-kokkos 
export OMP_NUM_THREADS=2
srun lmp -in step4.1_equilibration.inp
