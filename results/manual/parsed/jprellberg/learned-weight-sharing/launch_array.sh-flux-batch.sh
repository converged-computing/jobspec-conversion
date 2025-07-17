#!/bin/bash
#FLUX: --job-name=butterscotch-caramel-1899
#FLUX: -n=4
#FLUX: --queue=long
#FLUX: -t=518400
#FLUX: --urgency=16

echo "Starting $1 parallel processes on a single GPU"
for i in $(seq 1 $1); do
    PYTHONPATH="$PYTHONPATH:$(pwd)" python3.6 -u "$2" "$SLURM_ARRAY_TASK_ID" &
    pids[$i]=$!
done
for pid in ${pids[*]}; do
    wait $pid
done
