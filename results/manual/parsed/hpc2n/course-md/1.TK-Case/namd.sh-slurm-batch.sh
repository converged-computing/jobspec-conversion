#!/bin/bash
#SBATCH --account=Project_ID
#SBATCH --output=job_o.out
#SBATCH --error=job_o.err
#SBATCH --nodes=1
#SBATCH --ntasks=28
#SBATCH --cpus-per-task=1
#SBATCH --time=00:50:00

ml purge  > /dev/null 2>&1 
ml GCC/9.3.0  OpenMPI/4.0.3 
ml NAMD/2.14-mpi
mpirun -np 28 namd2 4ake_eq.conf > logfile.txt
