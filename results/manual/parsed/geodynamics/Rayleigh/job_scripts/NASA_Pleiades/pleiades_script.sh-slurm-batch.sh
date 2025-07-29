#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/geodynamics/Rayleigh/job_scripts/NASA_Pleiades/pleiades_script.sh
