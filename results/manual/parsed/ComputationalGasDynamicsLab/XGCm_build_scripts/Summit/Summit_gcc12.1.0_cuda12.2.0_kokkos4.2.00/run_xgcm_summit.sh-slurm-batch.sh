#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/ComputationalGasDynamicsLab/XGCm_build_scripts/Summit/Summit_gcc12.1.0_cuda12.2.0_kokkos4.2.00/run_xgcm_summit.sh
