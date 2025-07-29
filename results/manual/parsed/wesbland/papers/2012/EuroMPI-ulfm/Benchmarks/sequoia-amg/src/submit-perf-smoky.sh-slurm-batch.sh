#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/wesbland/papers/2012/EuroMPI-ulfm/Benchmarks/sequoia-amg/src/submit-perf-smoky.sh
