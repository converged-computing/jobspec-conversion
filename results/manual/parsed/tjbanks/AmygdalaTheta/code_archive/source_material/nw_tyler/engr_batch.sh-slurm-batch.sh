#!/bin/bash
#SBATCH --job-name=newLA
#SBATCH --output=1000BL.o%j.txt
#SBATCH --error=1000BL.e%j.txt
#SBATCH --mail-user=tbg28@mail.missouri.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=100
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=2-00:00:00

mpirun nrniv -mpi MC_main_small_forTheta_withinput.hoc #srun
