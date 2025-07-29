#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/sufyazi/qsmooth-norm-workflow/scripts/qsmooth-submitter.pbs
