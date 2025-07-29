#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/illinois-ceesd/drivers_flame1d/experiments/parsl/local_execution/runLassenBatch.sh
