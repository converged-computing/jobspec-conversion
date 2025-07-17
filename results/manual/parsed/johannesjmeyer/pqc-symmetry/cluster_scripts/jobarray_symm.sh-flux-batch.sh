#!/bin/bash
#FLUX: --job-name=frigid-eagle-5488
#FLUX: -c=8
#FLUX: -t=86400
#FLUX: --urgency=16

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
echo "Starting runs for symmetric case"
echo "##############################################"
echo " "
/usr/bin/time -f "\t%E real,\t%M kb MaxMem" python3 -u run_ttt.py -s true -n $steps -p $points -l tcemoid -f output/depth_7 -ss 0.004 -sr true -re $depth -ep true -epn $epochs -ce $ce
