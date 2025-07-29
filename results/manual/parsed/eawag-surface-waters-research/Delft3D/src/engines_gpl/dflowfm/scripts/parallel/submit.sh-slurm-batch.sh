#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/eawag-surface-waters-research/Delft3D/src/engines_gpl/dflowfm/scripts/parallel/submit.sh
