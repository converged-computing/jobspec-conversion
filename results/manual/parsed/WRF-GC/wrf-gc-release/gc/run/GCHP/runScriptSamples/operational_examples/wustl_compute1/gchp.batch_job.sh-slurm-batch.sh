#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/WRF-GC/wrf-gc-release/gc/run/GCHP/runScriptSamples/operational_examples/wustl_compute1/gchp.batch_job.sh
