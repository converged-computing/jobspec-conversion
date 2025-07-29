#!/bin/bash
#FLUX --job-name=bricky-hippo-1132
#FLUX --queue=cortex
#FLUX -t=172800
#FLUX --urgency=16

module load cuda
module unload intel
python Development/oc_ica/compare_models.py
