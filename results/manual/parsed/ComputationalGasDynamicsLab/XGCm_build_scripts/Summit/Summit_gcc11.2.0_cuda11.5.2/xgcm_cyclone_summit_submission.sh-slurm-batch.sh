#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/ComputationalGasDynamicsLab/XGCm_build_scripts/Summit/Summit_gcc11.2.0_cuda11.5.2/xgcm_cyclone_summit_submission.sh
