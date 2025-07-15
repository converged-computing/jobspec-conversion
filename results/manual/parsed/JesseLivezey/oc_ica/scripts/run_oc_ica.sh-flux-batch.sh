#!/bin/bash
#FLUX: --job-name=joyous-destiny-2688
#FLUX: --queue=cortex
#FLUX: -t=172800
#FLUX: --priority=16

module load cuda
module unload intel
python Development/oc_ica/compare_models.py
