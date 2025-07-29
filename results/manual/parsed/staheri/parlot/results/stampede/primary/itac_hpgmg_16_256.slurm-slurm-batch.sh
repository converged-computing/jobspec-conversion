#!/bin/bash
#SBATCH --job-name=itac_hpgmg_16_256
#SBATCH --account=Nixing-Scale-Bugs
#SBATCH --output=itac_hpgmg_16_256.%j
#SBATCH --nodes=16
#SBATCH --ntasks=256
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --partition=normal

export PATH='$PATH:/home1/02309/staheri/apps/p4est-itac/bin'

export PATH=$PATH:/home1/02309/staheri/apps/p4est-itac/bin
module load itac
JOBB=itac_hpgmg_16_256
mkdir -p $SCRATCH/results/$JOBB
cd $SCRATCH/results/$JOBB
time ibrun hpgmg-fv 4 1 > ../outputs/$JOBB.out
