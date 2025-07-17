#!/bin/bash
#FLUX: --job-name=epoch7
#FLUX: -c=8
#FLUX: --queue=ce-mri
#FLUX: -t=28800
#FLUX: --urgency=16

source activate simclr1
python downstream_eval.py --downstream_task linear_eval -tm SSL -rd "runs/Apr30_12-16-03_d3100_e150" --comment "_e150_cfg_linear_ssl" &
sleep 60
python downstream_eval.py --downstream_task linear_eval -tm SSL -rd "runs/Apr30_12-15-02_d3100_e90" --comment "_e90_cfg_linear_ssl"
