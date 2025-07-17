#!/bin/bash
#FLUX: --job-name=placid-fork-8418
#FLUX: --exclusive
#FLUX: -t=10800
#FLUX: --urgency=16

cd $WRKDIR/chirp_estimation
module load buildtool-easybuild
module load MATLAB/R2022a-nsc1
cd tetralith/jobs
if [ ! -d "../logs" ]
then
    echo "Log folder does not exists. Trying to mkdir"
    mkdir logs
fi
matlab -nosplash -nodesktop -r "fhc;"
