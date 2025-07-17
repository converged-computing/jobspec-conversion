#!/bin/bash
#FLUX: --job-name=toptw
#FLUX: -n=12
#FLUX: --queue=short
#FLUX: --urgency=16

set -e
function cleanup() {
    rm -rf $WORKDIR
}
MYUSER=$(whoami)
MYDIR='C:\Users\Arsala~1\Documents\GitHub\TOData\'
DATADIR=$MYDIR/data
SOLDIR=$MYDIR/sol
mkdir -p $DATADIR
mkdir -p $SOLDIR
for NO_OF_ROBOTS in 2 3
do
    for NO_OF_DEPOTS in 2 3
    do
        for NO_OF_TASKS in 5 10
        do 
            for FUEL in 50 75 150
            do
                for T_MAX in 150 300 600
                do
                    # Create Instance name
                    INSTANCE_STRING="R${NO_OF_ROBOTS}D${NO_OF_DEPOTS}T${NO_OF_TASKS}F${FUEL}Tmax${T_MAX}"
                    # submit job
                    sh cluster_single_job.sh ${INSTANCE_STRING}
                    # Sleep for 1 sec so that the machine is not overloaded
                    sleep 1
                done
            done
        done
    done
done
