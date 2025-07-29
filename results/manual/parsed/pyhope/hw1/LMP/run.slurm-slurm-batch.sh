#!/bin/bash
#SBATCH --job-name=lammps
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:59:00
#SBATCH --constraint=ntasks-per-node=1

module purge
module load anaconda3/2021.5
conda activate deepmd
lmp -in in.lammps
