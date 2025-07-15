#!/bin/bash
#FLUX: --job-name=eval-vqa-80
#FLUX: -t=36000
#FLUX: --priority=16

source ~/.bashrc
conda activate idefics
cd /home/naveensu/
python eval-idefics-vqa.py -m /data/user_data/naveensu/idefics-80 -o idefics-80_vqa.csv
