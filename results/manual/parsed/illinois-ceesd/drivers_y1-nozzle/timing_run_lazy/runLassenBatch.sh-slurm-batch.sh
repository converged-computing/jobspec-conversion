#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/illinois-ceesd/drivers_y1-nozzle/timing_run_lazy/runLassenBatch.sh
