#!/bin/bash
#SBATCH --job-name=simulateScenario13
#SBATCH --account=C3SE2018-1-15
#SBATCH --output=simulateScenario13.stdout
#SBATCH --error=simulateScenario13.stderr
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=10:00:00

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
