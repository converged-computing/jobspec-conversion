#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/yasahi-hpc/P3-miniapps/wk/sub_stdpar_vlp4d_mpi_V100.sh
