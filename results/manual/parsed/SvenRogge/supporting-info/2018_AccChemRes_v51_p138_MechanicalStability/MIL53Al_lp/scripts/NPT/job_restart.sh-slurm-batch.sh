#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/SvenRogge/supporting-info/2018_AccChemRes_v51_p138_MechanicalStability/MIL53Al_lp/scripts/NPT/job_restart.sh
