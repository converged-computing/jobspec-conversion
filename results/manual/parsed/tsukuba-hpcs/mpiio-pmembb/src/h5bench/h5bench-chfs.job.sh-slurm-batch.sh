#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/tsukuba-hpcs/mpiio-pmembb/src/h5bench/h5bench-chfs.job.sh
