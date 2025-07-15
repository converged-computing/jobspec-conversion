#!/bin/bash
#FLUX: --job-name=dinosaur-lizard-7275
#FLUX: --queue=luna-short
#FLUX: -t=240
#FLUX: --urgency=15

if false; then
    echo $NWORKERS
    echo $WORKER
    echo $XASLDIR
    echo $DATAFOLDER
    echo $NICENESS
fi 
nice -n $NICENESS `matlab-R2022b -nodesktop -nosplash -r "cd('$XASLDIR');ExploreASL('$DATAFOLDER', 0, 1, $WORKER, $NWORKERS);exit;"`
echo "xASL has ran as worker $WORKER of $NWORKER" 
exit 0
