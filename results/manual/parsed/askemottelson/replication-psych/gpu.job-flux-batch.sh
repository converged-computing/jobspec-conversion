#!/bin/bash
#FLUX: --job-name=replication-gpu
#FLUX: -c=8
#FLUX: --queue=red,brown
#FLUX: -t=10800
#FLUX: --urgency=16

echo "Running on $(hostname):"
module load Anaconda3/
eval "$(conda shell.bash hook)"
conda activate reppsych
python go.py
