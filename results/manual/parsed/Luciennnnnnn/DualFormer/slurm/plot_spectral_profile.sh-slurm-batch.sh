#!/bin/bash
#FLUX: --job-name=plot_spectral_profile
#FLUX: -c=8
#FLUX: --queue=dongliu
#FLUX: --urgency=16

nvidia-smi
python /home/sist/luoxin/projects/DualFormer/scripts/plot_spectral_profile.py
