#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/choderalab/espfit-experiment/experiments/spice-default/benchmark/pl-benchmark/tyk2/espaloma-protein-ligand/md1/lsf-submit.sh
