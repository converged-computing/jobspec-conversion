#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/JordiSalaJuarez/PPO/jobs/impala/jobscript_ninja_impala.sh
