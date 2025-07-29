#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/choderalab/geometry-benchmark-espaloma/qc-opt-geo/gaff-2.11/lsf-submit-step02b.sh
