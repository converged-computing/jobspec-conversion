#!/bin/bash
#FLUX: --job-name=lovable-diablo-3773
#FLUX: --queue=gpu_titanrtx
#FLUX: -t=174600
#FLUX: --urgency=16

module purge #Unload all loaded modules
module load 2019
module load TensorFlow
echo Running on Lisa System
python3 $HOME/main.py
