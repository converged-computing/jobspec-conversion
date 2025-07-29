#!/bin/bash
#SBATCH --job-name=namd
#SBATCH --account=Project_ID
#SBATCH --nodes=1
#SBATCH --ntasks=28
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00

ml purge  > /dev/null 2>&1 
ml GCC/9.3.0  OpenMPI/4.0.3
ml NAMD/2.14-mpi
srun namd2 step4_equilibration.inp > output_mpi.dat
