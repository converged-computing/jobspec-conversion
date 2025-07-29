#!/bin/bash
#SBATCH --job-name=energy_minim
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2GB
#SBATCH --time=02:00:00
#SBATCH --constraint=ntasks-per-node=1

module purge
module load gromacs/openmpi/intel/2020.4  
cd /home/tje3676/chem-class-2023/comp-lab-class/Week3/Data 
gmx_mpi mdrun -v -deffnm em
