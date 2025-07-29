#!/bin/bash
#SBATCH --job-name=lammps
#SBATCH --output=lammps_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=24G
#SBATCH --partition=batch

module purge                           # Unload all modules
module load lammps/may22               # Load LAMMPS
lmp\
 -k on g 1\
 -sf kk\
 -pk kokkos cuda/aware on neigh full comm device binsize 2.8\
 -var x 8 -var y 4 -var z 8\
 -in lammps_gpu.in
