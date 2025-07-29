#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/choderalab/geometry-benchmark-espaloma/qc-opt-geo/espaloma-0.3.0rc6/lsf-submit-step02b.sh
