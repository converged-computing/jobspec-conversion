#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/SciGaP/XSEDE-Job-Scripts/BigRed2/LAMMPS/lammps.submit
