#!/bin/bash
#SBATCH --job-name=pvscript
#SBATCH --account=pn68pi
#SBATCH --output=./pvscript.%j.%N.out
#SBATCH --nodes=16
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --partition=test
#SBATCH --constraint=ntasks-per-node=48
#SBATCH --chdir=.

module load slurm_setup                      # necessary workaround on SuperMUC-NG!
module load paraview-prebuild/5.8.0_mesa     # Look for available modules! But use MESA!
mpiexec pvbatch main.py       # try srun or use mpiexec's "-laucher" options if this does not work out-of-the-box
