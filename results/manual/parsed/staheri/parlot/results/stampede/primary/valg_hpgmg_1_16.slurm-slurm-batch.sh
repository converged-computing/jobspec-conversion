#!/bin/bash
#SBATCH --job-name=valg_hpgmg_1_16
#SBATCH --account=Nixing-Scale-Bugs
#SBATCH --output=valg_hpgmg_1_16.%j
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --partition=normal

export PATH='$PATH:$HOME/apps/valgrind/bin'

export PATH=$PATH:/home1/02309/staheri/apps/hpgmg-original/build/bin
export PATH=$PATH:$HOME/apps/valgrind/bin
JOBB=valg_hpgmg_1_16
mkdir -p $SCRATCH/results/$JOBB
cd $SCRATCH/results/$JOBB
time valgrind --tool=callgrind ibrun hpgmg-fv 4 1 > ../outputs/$JOBB.out
