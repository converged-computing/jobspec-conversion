#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/SvenRogge/supporting-info/2018_AccChemRes_v51_p138_MechanicalStability/UiO66Zr/scripts/NPT/job_yaff_lammps_restart.sh
