#!/bin/bash
#SBATCH --job-name=pin_all_p4est_1_16
#SBATCH --account=Nixing-Scale-Bugs
#SBATCH --output=pin_all_p4est_1_16.%j
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00

export PATH='$PATH:/home1/02309/staheri/apps/p4est-install/bin'

export PATH=$PATH:/home1/02309/staheri/apps/pin-install/pin-3.0-76991-gcc-linux/
export PATH=$PATH:/home1/02309/staheri/apps/p4est-install/bin
mkdir -p $SCRATCH/results/pin_all_p4est_1_16
cd $SCRATCH/results/pin_all_p4est_1_16
time ibrun pin -t ../../DBGpin17allimages.so -- p4est_mesh unit 9 > ../outputs/pin_all_p4est_1_16.out
