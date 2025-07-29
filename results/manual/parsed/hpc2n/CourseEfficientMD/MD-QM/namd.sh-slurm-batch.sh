#!/bin/bash
#SBATCH --account=Project_ID
#SBATCH --output=job_o.out
#SBATCH --error=job_o.err
#SBATCH --nodes=1
#SBATCH --ntasks=28
#SBATCH --cpus-per-task=1
#SBATCH --time=00:50:00

ml GCC/7.3.0-2.30  OpenMPI/3.1.1
ml NAMD/2.13-mpi
mpirun -np 28 namd2 4ake_eq.conf > logfile.txt
