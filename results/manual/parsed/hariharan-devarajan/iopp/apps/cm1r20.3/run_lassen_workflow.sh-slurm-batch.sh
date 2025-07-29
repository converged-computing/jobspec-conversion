#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/hariharan-devarajan/iopp/apps/cm1r20.3/run_lassen_workflow.sh
