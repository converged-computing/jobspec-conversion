#!/bin/bash
#SBATCH --job-name=qmmm
#SBATCH --account=Project_ID
#SBATCH --nodes=1
#SBATCH --ntasks=14
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00

ml purge  > /dev/null 2>&1 
ml GCC/10.3.0  OpenMPI/4.1.1
ml NAMD/2.14-nompi
ml ORCA/5.0.1
namd2 +p4 QMMM-Min.conf   > output_minimization.dat
