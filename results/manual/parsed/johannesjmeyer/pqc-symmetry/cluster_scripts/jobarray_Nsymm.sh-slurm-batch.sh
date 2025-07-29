#!/bin/bash
#SBATCH --mail-user=frarzani@physik.fu-berlin.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=15000
#SBATCH --time=1-00:00:00
#SBATCH --chdir=/home/frarzani/pqc
#SBATCH --array=0-19%10

export MPLCONFIGDIR='../mpl'

export MPLCONFIGDIR=../mpl
source ./ttt/bin/activate
depth=7 # number of repetitions of layers
steps=20 # number of learning steps per epoch
epochs=25 # number of epochs
points=30 # number of points to compute gradient
echo " "
echo "##############################################"
echo "Circuit depth: $depth"  
echo "Parallel runs: $parruns"  
echo "Toral runs: $datapoints"
echo "Starting runs for NON symmetric case"
echo "##############################################"
echo " "
/usr/bin/time -f "\t%E real,\t%M kb MaxMem" python3 -u run_ttt.py -s false -n $steps -p $points -l tcemoid -f output/depth_7 -ss 0.004 -sr true -re $depth -ep true -epn $epochs -ec true
