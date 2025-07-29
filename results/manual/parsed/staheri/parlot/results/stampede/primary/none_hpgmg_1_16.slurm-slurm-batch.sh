#!/bin/bash
#SBATCH --job-name=none_hpgmg_1_16
#SBATCH --account=Nixing-Scale-Bugs
#SBATCH --output=none_hpgmg_1_16.%j
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00

export PATH='$PATH:/home1/02309/staheri/apps/hpgmg-original/build/bin'

export PATH=$PATH:/home1/02309/staheri/apps/hpgmg-original/build/bin
JOBB=none_hpgmg_1_16
mkdir -p $SCRATCH/results/$JOBB
cd $SCRATCH/results/$JOBB
time ibrun hpgmg-fv 4 1 > ../outputs/$JOBB.out
