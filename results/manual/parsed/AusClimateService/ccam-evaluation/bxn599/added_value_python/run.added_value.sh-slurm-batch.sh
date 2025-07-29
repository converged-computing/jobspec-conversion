#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/AusClimateService/ccam-evaluation/bxn599/added_value_python/run.added_value.sh
