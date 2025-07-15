#!/bin/bash
#FLUX: --job-name=grabDeut
#FLUX: --queue=short
#FLUX: -t=7200
#FLUX: --priority=16

source ~/_02_RMG_envs/RMG_julia_env/.config_file
source activate rmg_julia_env
python -u Grabow_sbr_script.py  #$CTI_FILE $RMG_MODEL
