#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/lenovo/openlico/core/apps/template/lico/core/template/templates/scheduler/lsf-lammps.sh.in
