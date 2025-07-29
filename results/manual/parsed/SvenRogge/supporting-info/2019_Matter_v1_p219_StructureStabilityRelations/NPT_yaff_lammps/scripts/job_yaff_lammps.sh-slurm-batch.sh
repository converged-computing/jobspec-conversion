#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/SvenRogge/supporting-info/2019_Matter_v1_p219_StructureStabilityRelations/NPT_yaff_lammps/scripts/job_yaff_lammps.sh
