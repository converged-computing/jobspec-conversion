#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/jaime-galiana/automated-CFD-ASO-with-SU2/submit_compileSU2.pbs
