#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=00:04:00
#SBATCH --qos=low

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
