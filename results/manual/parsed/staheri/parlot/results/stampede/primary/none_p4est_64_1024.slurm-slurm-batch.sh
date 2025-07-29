#!/bin/bash
#SBATCH --job-name=none_p4est_64_1024
#SBATCH --account=Nixing-Scale-Bugs
#SBATCH --output=none_p4est_64_1024.%j
#SBATCH --nodes=64
#SBATCH --ntasks=1024
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00

export PATH='$PATH:/home1/02309/staheri/apps/p4est-install/bin'

export PATH=$PATH:/home1/02309/staheri/apps/p4est-install/bin
JOBB=none_p4est_64_1024
mkdir -p $SCRATCH/results/$JOBB
cd $SCRATCH/results/$JOBB
time ibrun p4est_mesh unit 9 > ../outputs/$JOBB.out
