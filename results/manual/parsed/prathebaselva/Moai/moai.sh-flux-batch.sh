#!/bin/bash
#FLUX: --job-name=moai_step1000_archv4_lr1e3_moai23
#FLUX: --queue=gypsum-titanx
#FLUX: -t=259200
#FLUX: --urgency=16

module load cuda11/11.2.1
python train_multi.py --cfg './src/configs/config_moaiparamdiffusion.yml' 
