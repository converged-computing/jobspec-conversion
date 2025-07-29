#!/bin/bash
#FLUX: --job-name=test-cpu
#FLUX: -c=2
#FLUX: --queue=rng-short
#FLUX: -t=1200
#FLUX: --urgency=15

if 0; then
    echo $NWORKERS
    echo $WORKER
    echo $XASLDIR
    echo $DATAFOLDER
fi 
nice -n 10 `matlab -nodesktop -nosplash -r "cd('$XASLDIR');ExploreASL('$DATAFOLDER', 0, 1, $WORKER, $NWORKERS);exit;"`
echo "xASL has ran as worker $WORKER of $NWORKER" 
exit 0
