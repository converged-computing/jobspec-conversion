#!/bin/bash
#FLUX: --job-name=test1
#FLUX: --queue=normal
#FLUX: --priority=16

PROBABILITY=0.9
LENGTH=1000
SHUFFLES=`expr "$LENGTH" \* "$LENGTH" \* "$LENGTH" `
module load gnu10
mkdir -p /scratch/ktran44/bernoulli/results/$LENGTH/$PROBABILITY
cd /scratch/ktran44/bernoulli/faster_polyforms/
./target/release/main --length $LENGTH --export analysis --shuffles $SHUFFLES  --norender --bernoulli $PROBABILITY > /scratch/ktran44/bernoulli/results/$LENGTH/$PROBABILITY/polyform_$(uuidgen).txt
