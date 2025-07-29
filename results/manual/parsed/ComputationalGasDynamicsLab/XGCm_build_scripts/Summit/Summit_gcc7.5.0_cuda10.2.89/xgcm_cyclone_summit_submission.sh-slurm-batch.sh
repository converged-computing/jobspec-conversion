#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/ComputationalGasDynamicsLab/XGCm_build_scripts/Summit/Summit_gcc7.5.0_cuda10.2.89/xgcm_cyclone_summit_submission.sh
