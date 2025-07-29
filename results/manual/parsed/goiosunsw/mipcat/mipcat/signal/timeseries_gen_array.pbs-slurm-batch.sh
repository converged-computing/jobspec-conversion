#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/goiosunsw/mipcat/mipcat/signal/timeseries_gen_array.pbs
