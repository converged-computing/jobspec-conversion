#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/HPCToolkit/hpctoolkit-tutorial-examples/cpu/mpi%2Bopenmp/hpcg/job-scripts/xhpcg-summit
