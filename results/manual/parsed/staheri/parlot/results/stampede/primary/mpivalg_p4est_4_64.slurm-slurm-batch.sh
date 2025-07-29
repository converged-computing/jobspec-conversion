#!/bin/bash
#SBATCH --job-name=mpivalg_p4est_4_64
#SBATCH --account=Nixing-Scale-Bugs
#SBATCH --output=mpivalg_p4est_4_64.%j
#SBATCH --nodes=4
#SBATCH --ntasks=64
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --partition=normal

export PATH='$PATH:$HOME/apps/valgrind/bin'

export PATH=$PATH:/home1/02309/staheri/apps/p4est-install/bin
export PATH=$PATH:$HOME/apps/valgrind/bin
JOBB=mpivalg_p4est_4_64
mkdir -p $SCRATCH/results/$JOBB
cd $SCRATCH/results/$JOBB
time ibrun valgrind --tool=callgrind p4est_mesh unit 9 > ../outputs/$JOBB.out
