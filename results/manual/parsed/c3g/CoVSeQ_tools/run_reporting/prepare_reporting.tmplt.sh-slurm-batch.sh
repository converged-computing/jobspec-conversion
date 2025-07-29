#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/c3g/CoVSeQ_tools/run_reporting/prepare_reporting.tmplt.sh
