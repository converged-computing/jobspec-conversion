#!/bin/bash
#SBATCH --job-name=newLA
#SBATCH --output=1000BL.o%j.txt
#SBATCH --error=1000BL.e%j.txt
#SBATCH --mail-user=ffvxb@mail.missouri.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=176
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=2-00:00:00

mpirun nrniv -mpi BL_main_small_lightdis_randompluses_poisson_automated_onlinepulses_PRC_skip.hoc #srun
