#!/bin/bash
#FLUX: --job-name=simulateScenario80
#FLUX: --queue=glenn
#FLUX: -t=36000
#FLUX: --urgency=16

module load matlab
cp  -r $SLURM_SUBMIT_DIR/* $TMPDIR
cd $TMPDIR
array=(  "-6;8;32000000000;100000000000" "-5;8;32000000000;100000000000" "-4;8;32000000000;100000000000" "-3;8;32000000000;100000000000" "-2;8;32000000000;100000000000" "-1;8;32000000000;100000000000" "0;8;32000000000;100000000000" "1;8;32000000000;100000000000" "2;8;32000000000;100000000000" "3;8;32000000000;100000000000" "4;8;32000000000;100000000000" "5;8;32000000000;100000000000" "6;8;32000000000;100000000000" "7;8;32000000000;100000000000" "8;8;32000000000;100000000000" "9;8;32000000000;100000000000" )
for i in "${array[@]}"
do
    arr=(${i//;/ })
    echo ${arr[0]} ${arr[1]} ${arr[2]} ${arr[3]}
    RunMatlab.sh -o "-nodesktop -nosplash -singleCompThread -r \"simulateScenario(${arr[0]},${arr[1]},${arr[2]},${arr[3]});\"" & 
    sleep 0.1
done
wait
mkdir $SLURM_SUBMIT_DIR/simulateScenario80
cp -rf $TMPDIR/results/* $SLURM_SUBMIT_DIR/simulateScenario80
rm -rf $TMPDIR/*
