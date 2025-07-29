#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/niladridas/OT_NN_Train/MATLAB/OT_codes/extern/PFPFGMM_soumyacode/test_pfpfgmm.sh
