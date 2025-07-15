#!/bin/bash
#FLUX: --job-name=epoch7
#FLUX: --queue=ce-mri
#FLUX: -t=28800
#FLUX: --urgency=16

source activate simclr1
python downstream_eval.py --downstream_task linear_eval -tm SSL -rd "runs/May01_10-33-51_d3102_tmp175" --comment "_tmp175_cfg_linear_ssl" -e 400
