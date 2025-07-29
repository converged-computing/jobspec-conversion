#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/geoschem/geos-chem/run/GCHP/runScriptSamples/operational_examples/wustl_compute1/c360_requeuing.sh
