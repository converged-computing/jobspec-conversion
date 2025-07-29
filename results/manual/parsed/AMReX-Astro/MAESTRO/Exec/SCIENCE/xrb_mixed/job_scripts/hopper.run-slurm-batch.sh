#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/AMReX-Astro/MAESTRO/Exec/SCIENCE/xrb_mixed/job_scripts/hopper.run
