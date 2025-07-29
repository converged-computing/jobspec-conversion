#!/bin/bash
#SBATCH --job-name=cmake_mTrans_opt
#SBATCH --account=pc2-mitarbeiter
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00

module load intelFPGA_pro/20.4.0 nalla_pcie/19.4.0_hpc
cd ../build
make simple_syn
