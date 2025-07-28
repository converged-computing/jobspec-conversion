#!/bin/bash
#FLUX: --job-name=sticky-peanut-butter-9591
#FLUX: --queue=cortex
#FLUX: -t=172800
#FLUX: --urgency=16

module load cuda
module unload intel
python Development/oc_ica/compare_models.py
