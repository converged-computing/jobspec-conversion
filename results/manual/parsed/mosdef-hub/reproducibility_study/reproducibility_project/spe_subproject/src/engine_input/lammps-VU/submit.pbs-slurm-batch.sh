#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/mosdef-hub/reproducibility_study/reproducibility_project/spe_subproject/src/engine_input/lammps-VU/submit.pbs
