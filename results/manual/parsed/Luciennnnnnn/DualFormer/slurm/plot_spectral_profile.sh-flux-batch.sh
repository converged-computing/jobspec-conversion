#!/bin/bash
#FLUX: --job-name=buttery-animal-5431
#FLUX: -c=8
#FLUX: --urgency=16

nvidia-smi
python /home/sist/luoxin/projects/DualFormer/scripts/plot_spectral_profile.py
