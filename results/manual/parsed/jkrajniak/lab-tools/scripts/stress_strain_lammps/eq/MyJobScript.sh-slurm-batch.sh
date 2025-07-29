#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/jkrajniak/lab-tools/scripts/stress_strain_lammps/eq/MyJobScript.sh
