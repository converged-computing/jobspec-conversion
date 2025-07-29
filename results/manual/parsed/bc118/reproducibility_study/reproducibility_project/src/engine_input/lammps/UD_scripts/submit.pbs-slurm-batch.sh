#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/bc118/reproducibility_study/reproducibility_project/src/engine_input/lammps/UD_scripts/submit.pbs
