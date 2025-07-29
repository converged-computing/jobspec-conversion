#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/pc2/hpcc_fpga_eval_21/scripts/synthesis/PTRANS/build_520n_cygnus.sh
