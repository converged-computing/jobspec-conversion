#!/bin/bash
#SBATCH --output=mic-lammps.out
#SBATCH --mail-user=vunetid@vanderbilt.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=64G
#SBATCH --time=04:00:00

setpkgs -a intel_cluster_studio_compiler
setpkgs -a lammps_mic
srun -n 2 lmp_intel_phi -in lammps.in
