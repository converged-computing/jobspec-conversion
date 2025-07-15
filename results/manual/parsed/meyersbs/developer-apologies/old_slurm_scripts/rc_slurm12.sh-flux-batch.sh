#!/bin/bash
#FLUX: --job-name=lovely-kitty-7068
#FLUX: --urgency=16

echo "Loading environment"
spack env activate mistakes-21091601
echo "Doing stuff..."
time python3 -u main.py apology_stats data_aps/ 32
date
