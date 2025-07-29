#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/NicoDeshler/Compressive-Quantum-Imaging/run_array_PersonickWaveletEstimation_MVGBM.sh
