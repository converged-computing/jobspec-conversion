#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/slateci/bosco-override-template/RESOURCE_NAME/bosco_override/glite/bin/pbs_submit.sh
