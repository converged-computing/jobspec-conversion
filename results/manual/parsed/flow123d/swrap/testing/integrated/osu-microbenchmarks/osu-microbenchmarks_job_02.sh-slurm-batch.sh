#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/flow123d/swrap/testing/integrated/osu-microbenchmarks/osu-microbenchmarks_job_02.sh
