#!/bin/bash
#FLUX: --job-name=muffled-banana-8030
#FLUX: --priority=16

module load matlab
cp  -r $SLURM_SUBMIT_DIR/* $TMPDIR
cd $TMPDIR
array=(  "-7;-1;32000000000;50000000000" "-6;-1;32000000000;50000000000" "-5;-1;32000000000;50000000000" "-4;-1;32000000000;50000000000" "-3;-1;32000000000;50000000000" "-2;-1;32000000000;50000000000" "-1;-1;32000000000;50000000000" "0;-1;32000000000;50000000000" "1;-1;32000000000;50000000000" "2;-1;32000000000;50000000000" "3;-1;32000000000;50000000000" "4;-1;32000000000;50000000000" "5;-1;32000000000;50000000000" "6;-1;32000000000;50000000000" "7;-1;32000000000;50000000000" "8;-1;32000000000;50000000000" )
for i in "${array[@]}"
do
    arr=(${i//;/ })
    echo ${arr[0]} ${arr[1]} ${arr[2]} ${arr[3]}
    RunMatlab.sh -o "-nodesktop -nosplash -singleCompThread -r \"simulateScenario(${arr[0]},${arr[1]},${arr[2]},${arr[3]});\"" & 
    sleep 0.1
done
wait
mkdir $SLURM_SUBMIT_DIR/simulateScenario13
cp -rf $TMPDIR/results/* $SLURM_SUBMIT_DIR/simulateScenario13
rm -rf $TMPDIR/*
