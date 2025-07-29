#!/bin/bash
#SBATCH --job-name=vtune_hpgmg_64_1024
#SBATCH --account=Nixing-Scale-Bugs
#SBATCH --output=vtune_hpgmg_64_1024.%j
#SBATCH --nodes=64
#SBATCH --ntasks=1024
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00

export PATH='$PATH:$HOME/apps/valgrind/bin'

export PATH=$PATH:/home1/02309/staheri/apps/hpgmg-original/build/bin
export PATH=$PATH:$HOME/apps/valgrind/bin
module load vtune
JOBB=vtune_hpgmg_64_1024
mkdir -p $SCRATCH/results/$JOBB
cd $SCRATCH/results/$JOBB
time ibrun amplxe-cl -collect hotspots -result-dir "./$(hostname)"  hpgmg-fv 4 1 > ../outputs/$JOBB.out
