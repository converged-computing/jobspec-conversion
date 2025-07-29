#!/bin/bash
#SBATCH --job-name=lammps
#SBATCH --output=lammps_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=64
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=24G

module purge                           # Unload all modules
module load gcc lammps                 # Load LAMMPS
srun lmp\
 -var x 8 -var y 4 -var z 8\
 -in lammps_gpu.in
