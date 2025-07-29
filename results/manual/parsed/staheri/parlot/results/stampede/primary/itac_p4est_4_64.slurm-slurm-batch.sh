#!/bin/bash
#SBATCH --job-name=itac_p4est_4_64
#SBATCH --account=Nixing-Scale-Bugs
#SBATCH --output=itac_p4est_4_64.%j
#SBATCH --nodes=4
#SBATCH --ntasks=64
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00

export PATH='$PATH:/home1/02309/staheri/apps/p4est-itac/bin'

export PATH=$PATH:/home1/02309/staheri/apps/p4est-itac/bin
module load itac
JOBB=itac_p4est_4_64
mkdir -p $SCRATCH/results/$JOBB
cd $SCRATCH/results/$JOBB
time ibrun p4est_mesh unit 9 > ../outputs/$JOBB.out
