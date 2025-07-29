#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/mosdef-hub/reproducibility_study/reproducibility_project/methane_systemsize/lammps_small_dt/templates/rahman_gmx.sh
