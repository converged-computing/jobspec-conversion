#!/bin/bash
#SBATCH --job-name=JDAHFpEF
#SBATCH --mail-user=jijoderick.abraham@uq.net.au
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=10

module load mpi/openmpi-x86_64
mpirun singularity exec /home/s4657117/HCM-project/SingularitY/hcm-project.img python Python_filename.py
