#!/bin/bash
#FLUX: --job-name=hairy-signal-7484
#FLUX: -t=3000
#FLUX: --urgency=16

cd $WRKDIR/chirp_estimation
module load buildtool-easybuild
module load Anaconda3/2021.05-nsc1
source ./venv/bin/activate
python setup.py develop
cd tetralith
if [ ! -d "./logs" ]
then
    echo "Log folder does not exists. Trying to mkdir"
    mkdir logs
fi
python ./jobs/fastf0nls.py -harmonic 0 > ./logs/fastf0nls.log &
python ./jobs/fastf0nls.py -harmonic 1 > ./logs/harmonic_fastf0nls.log &
wait
