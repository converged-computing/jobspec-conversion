#!/bin/bash
#FLUX: --job-name=da_Holocene
#FLUX: -t=21600
#FLUX: --urgency=16

srun python -u da_main_code.py config.yml
