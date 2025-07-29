#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/Libensemble/libensemble/examples/libE_submission_scripts/summit_submit_mproc.sh
