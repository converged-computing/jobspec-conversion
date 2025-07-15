#!/bin/bash
#FLUX: --job-name=down_ft1
#FLUX: --queue=ce-mri
#FLUX: -t=28800
#FLUX: --priority=16

source activate simclr1
python downstream_eval.py --downstream_task fine_tune -tm Scratch --config_file runs/tmp_default/config.yml -e 400 --comment "_default_cfg_ft_scratch_e400" &
sleep 60
python downstream_eval.py --downstream_task fine_tune -tm ImageNet --config_file runs/tmp_default/config.yml -e 400 --comment "_default_cfg_ft_imagenet_e400" &
sleep 60
python downstream_eval.py --downstream_task fine_tune -tm SSL -rd "runs/Apr30_03-51-19_d3099_default" -e 400 --comment "_default_cfg_ft_SSL_e400"
