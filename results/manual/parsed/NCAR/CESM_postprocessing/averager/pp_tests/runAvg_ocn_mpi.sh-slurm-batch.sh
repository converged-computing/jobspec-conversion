#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/NCAR/CESM_postprocessing/averager/pp_tests/runAvg_ocn_mpi.sh
