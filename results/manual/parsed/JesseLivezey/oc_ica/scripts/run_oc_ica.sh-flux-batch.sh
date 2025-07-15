#!/bin/bash
#FLUX: --job-name=astute-omelette-5711
#FLUX: --queue=cortex
#FLUX: -t=172800
#FLUX: --urgency=16

module load cuda
module unload intel
python Development/oc_ica/compare_models.py
