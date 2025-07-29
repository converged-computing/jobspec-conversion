#!/bin/bash
#SBATCH --job-name=test-cpu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=8G
#SBATCH --time=00:20:00
#SBATCH --qos=low

if 0; then
    echo $NWORKERS
    echo $WORKER
    echo $XASLDIR
    echo $DATAFOLDER
fi 
nice -n 10 `matlab -nodesktop -nosplash -r "cd('$XASLDIR');ExploreASL('$DATAFOLDER', 0, 1, $WORKER, $NWORKERS);exit;"`
echo "xASL has ran as worker $WORKER of $NWORKER" 
exit 0
