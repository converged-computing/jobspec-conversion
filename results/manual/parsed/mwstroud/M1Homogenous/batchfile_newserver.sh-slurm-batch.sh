#!/bin/bash
#SBATCH --job-name=MC_sim
#SBATCH --output=1000BL.o%j.txt
#SBATCH --error=1000BL.e%j.txt
#SBATCH --mail-user=mwsrgf@mail.missouri.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=50
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=2-00:00:00

mpirun nrniv -mpi -python run_network.py config.json #srun
