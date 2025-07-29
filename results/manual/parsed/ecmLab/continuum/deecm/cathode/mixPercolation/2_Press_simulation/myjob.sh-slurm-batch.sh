#!/bin/bash
#SBATCH --job-name=NMC_LPS
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10g
#SBATCH --time=00:30:00
#SBATCH --partition=tier3
#SBATCH --constraint=ntasks-per-node=20

spack load lammps@2023208 /cuxhkce
srun lmp -log none -in mr.in
