#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/algorithmcardboard/Most-hapennning-places-NYC/src/nyctaxi/job_runner.q
