#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/jimmielin/geos-chem/run/GCHP/runScriptSamples/operational_examples/wustl_gcst/c360_requeuing.sh
