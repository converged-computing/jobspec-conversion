#!/bin/bash
#FLUX: --job-name=fugly-pastry-5590
#FLUX: -c=20
#FLUX: --queue=short
#FLUX: --urgency=16

set -e
function cleanup() {
    rm -rf $WORKDIR
}
MYUSER=$(whoami)
MYDIR='/home/aakhter/work/TOData'
DATADIR=$MYDIR/data
SOLDIR=$MYDIR/sol
THISJOB=$MYDIR
WORKDIR=$LOCALDIR/$MYUSER/$THISJOB
trap cleanup EXIT SIGINT SIGTERM
for FUEL in 50 75 100 125 150
do
    for T_MAX in 50 75 150 300 450 600
    do
        for ITER in {0..9}
        do
            for SOLVER_TYPE in F1 F2 F3 F4 F5 F6 F7 F8
            do
                INSTANCE_STRING=$1
                ITERATION_STRING="${INSTANCE_STRING}F${FUEL}Tmax${T_MAX}Iter${ITER}"
                echo $ITERATION_STRING $SOLVER_TYPE
                python $MYDIR/main.py ${ITERATION_STRING} ${SOLVER_TYPE}
            done
        done
    done
done
