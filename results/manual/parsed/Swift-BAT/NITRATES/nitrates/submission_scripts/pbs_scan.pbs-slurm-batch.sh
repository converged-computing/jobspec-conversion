#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/Swift-BAT/NITRATES/nitrates/submission_scripts/pbs_scan.pbs
