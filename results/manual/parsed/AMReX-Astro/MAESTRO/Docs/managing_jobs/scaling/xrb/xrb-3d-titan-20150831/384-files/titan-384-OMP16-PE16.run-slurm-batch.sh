#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/AMReX-Astro/MAESTRO/Docs/managing_jobs/scaling/xrb/xrb-3d-titan-20150831/384-files/titan-384-OMP16-PE16.run
