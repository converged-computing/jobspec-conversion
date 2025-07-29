#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/DiRAC-benchmarks/DiRAC3-testsuite/src/ior/ARCHER_submission_scripts/IOR_DiRAC_MPIIO/NW.FPS/NW.FPS.qsub
