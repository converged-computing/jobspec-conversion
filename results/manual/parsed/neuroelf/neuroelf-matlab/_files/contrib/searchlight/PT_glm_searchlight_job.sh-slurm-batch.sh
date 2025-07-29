#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/neuroelf/neuroelf-matlab/_files/contrib/searchlight/PT_glm_searchlight_job.sh
