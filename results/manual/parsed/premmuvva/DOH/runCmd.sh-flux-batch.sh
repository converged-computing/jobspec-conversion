#!/bin/bash
#FLUX: --job-name=wobbly-itch-6203
#FLUX: -c=6
#FLUX: -t=86340
#FLUX: --priority=16

echo "Reached before python lines of file: $1 start"
date
module load TensorFlow/2.7.1-foss-2021b-CUDA-11.4.1 
source ~/.zshrc
echo "Reached before python lines of file: $1"
venv/bin/python $1
echo "After python lines of file: $1"
date
