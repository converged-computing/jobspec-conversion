#!/bin/bash
#FLUX: --job-name=Polar
#FLUX: --queue=gpu
#FLUX: -t=172800
#FLUX: --urgency=16

echo "Start test"
module load matlab 
matlab -nodesktop -r "run('NeuralPolarDecode.m'); exit(0);"
echo "End test"
