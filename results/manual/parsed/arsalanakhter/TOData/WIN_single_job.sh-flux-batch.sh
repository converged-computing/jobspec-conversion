#!/bin/bash
#FLUX: --job-name=wobbly-onion-0437
#FLUX: --urgency=16

set -e
function cleanup() {
    rm -rf $WORKDIR
}
MYUSER=$(whoami)
MYDIR='C:\Users\Arsala~1\Documents\GitHub\TOData\'
DATADIR=$MYDIR/data
SOLDIR=$MYDIR/sol
for ITER in {0..9}
do
    for SOLVER_TYPE in F1 F2 F3 F4
    do
        INSTANCE_STRING=$1
        ITERATION_STRING="${INSTANCE_STRING}Iter${ITER}"
        echo $ITERATION_STRING $SOLVER_TYPE
        python $MYDIR/main.py ${ITERATION_STRING} ${SOLVER_TYPE}
    done
done
