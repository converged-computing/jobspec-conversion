#!/bin/bash
#SBATCH --job-name=MC_sim
#SBATCH --output=1000BL.o%j.txt
#SBATCH --error=1000BL.e%j.txt
#SBATCH --mail-user=mwsrgf@mail.missouri.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G
#SBATCH --time=2-00:00:00

python build_network.py #srun
