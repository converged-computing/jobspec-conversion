#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/AMReX-Astro/MAESTRO/Docs/managing_jobs/scaling/xrb/xrb-3d-titan-20140617/titan-scripts/titan-64-MPI-PE8.run
