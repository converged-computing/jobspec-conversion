#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/mvdoc/budapest-fmri-data/scripts/preprocessing-fmri/run-fmriprep-discovery-submit.pbs
