#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/choderalab/espfit-experiment/experiments/spice2-default/data/hdf5/lsf-submit.sh
