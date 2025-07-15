#!/bin/bash
#FLUX: --job-name=modern-nn-potentials
#FLUX: -c=20
#FLUX: -t=1800
#FLUX: --urgency=16

source activate modern-nn-potentials
cd ~/projects/modern_nn_potentials/scripts
python ./posteriors_script.py
