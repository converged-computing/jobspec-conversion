#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/mpicbg-scicomp/gearshifft_publication/results/P100-PCIE-16GB/clfft-2.12.2/hypnos.sh
