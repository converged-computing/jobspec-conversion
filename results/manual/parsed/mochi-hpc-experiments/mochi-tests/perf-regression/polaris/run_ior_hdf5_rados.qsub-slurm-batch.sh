#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/mochi-hpc-experiments/mochi-tests/perf-regression/polaris/run_ior_hdf5_rados.qsub
