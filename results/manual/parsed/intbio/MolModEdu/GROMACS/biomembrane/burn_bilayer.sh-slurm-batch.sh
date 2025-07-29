#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/intbio/MolModEdu/GROMACS/biomembrane/burn_bilayer.sh
