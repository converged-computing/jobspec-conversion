#!/bin/bash
#FLUX: --job-name=fugly-fudge-8941
#FLUX: --urgency=16

module purge
module ohpc
date
for tau in $(seq 0.0001 0.0001 0.0005); do
    echo "Running script with tau=$tau"
    python main.py --tau $tau &
done
wait
date
