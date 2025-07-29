#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/lammpstutorials/lammpstutorials-inputs/level3/free-energy-calculation/Exercises/MoleculeAdsorption/run_dahu.sh
