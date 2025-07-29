#!/bin/bash
#SBATCH --job-name=paraview
#SBATCH --output=parav_now.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=120000
#SBATCH --time=1-00:00:00
#SBATCH --partition=normal
#SBATCH --constraint=ntasks-per-node=1

mpirun /home/kevinsch/software/ParaView-5.6.0-MPI-Linux-64bit/bin/pvserver --force-offscreen-rendering
