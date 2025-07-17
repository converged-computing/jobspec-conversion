#!/bin/bash
#FLUX: --job-name=torch-test
#FLUX: -t=300
#FLUX: --urgency=16

module load singularity 
singularity exec --nv /home/schickerur/venv/python-va3.sif  python3 gpu6.py
