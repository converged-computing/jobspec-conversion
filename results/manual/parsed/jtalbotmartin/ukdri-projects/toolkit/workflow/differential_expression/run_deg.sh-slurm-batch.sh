#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/jtalbotmartin/ukdri-projects/toolkit/workflow/differential_expression/run_deg.sh
