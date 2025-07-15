#!/bin/bash
#FLUX: --job-name=fuzzy-mango-9260
#FLUX: --urgency=16

module purge #Unload all loaded modules
module load 2019
module load TensorFlow
echo Running on Lisa System
python3 $HOME/main.py
