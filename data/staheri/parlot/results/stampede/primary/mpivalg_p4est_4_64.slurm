#!/bin/bash
#SBATCH -A Nixing-Scale-Bugs  # account name
#SBATCH -J mpivalg_p4est_4_64       # job name
#SBATCH -o mpivalg_p4est_4_64.%j    # name of the output and error file
#SBATCH -N 4            # total number of nodes requested
#SBATCH -n 64            # total number of tasks requested
#SBATCH -p normal       # queue name
#SBATCH -t 00:10:00     # expected maximum runtime (hh:mm:ss)
 
#export PATH=$PATH:/home1/02309/staheri/apps/pin-install/pin-3.0-76991-gcc-linux/
#export PATH=$PATH:/home1/02309/staheri/apps/hpgmg-itac/build/bin/
#export PATH=$PATH:/home1/02309/staheri/apps/hpgmg-original/build/bin
#export PATH=$PATH:/home1/02309/staheri/apps/p4est-itac/bin
export PATH=$PATH:/home1/02309/staheri/apps/p4est-install/bin
export PATH=$PATH:$HOME/apps/valgrind/bin

#module load itac
#module load vtune

JOBB=mpivalg_p4est_4_64

mkdir -p $SCRATCH/results/$JOBB

cd $SCRATCH/results/$JOBB

#time valgrind --tool=callgrind ibrun p4est_mesh unit 9 > ../outputs/$JOBB.out
time ibrun valgrind --tool=callgrind p4est_mesh unit 9 > ../outputs/$JOBB.out




