#!/bin/bash
#FLUX: --job-name=evopcgrl
#FLUX: -c=48
#FLUX: -t=172800
#FLUX: --priority=16

cd /scratch/zj2086/control-pcgrl
source activate
conda activate pcgrl
start=$SECONDS
while ! python evo/evolve.py -la 0
do
    duration=$((( SECONDS - start ) / 60))
    echo "Script returned error after $duration minutes"
    if [ $duration -lt 60 ]
    then
      echo "Too soon. Something is wrong. Terminating node."
      exit 42
    else
      echo "Killing ray processes and re-launching script."
      ray stop
      pkill ray
      pkill -9 ray
      pkill python
      pkill -9 python
      start=$SECONDS
    fi
done
