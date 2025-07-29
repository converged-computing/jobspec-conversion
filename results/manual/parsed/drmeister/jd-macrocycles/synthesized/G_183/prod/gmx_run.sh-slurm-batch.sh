#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/drmeister/jd-macrocycles/synthesized/G_183/prod/gmx_run.sh
