#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/Data-to-Insight-Center/CKN/komadu_client/scripts/job-summit.sh
